//
//  NotificationService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 10/09/23.
//

//Import Error
//Xcode -> File -> Swift Packages -> Reset Package Caches

import Foundation
import Firebase

class NotificationService {
    
    static func fetchNotifications(uid: String) async throws -> [Notification] {
        let snapshot = try await FirestoreConstants.notificationsCollection.whereField("targetID", isEqualTo: uid).getDocuments()
        var notifications = snapshot.documents.compactMap({ try? $0.data(as: Notification.self)})
        
        for (index, notification) in notifications.enumerated() {
            notifications[index].user = try await UserService.fetchUser(uid: notification.ownerID)
            notifications[index].notificationType = NotificationType(rawValue: notification.notificationTypeString)
            if notification.postID != nil {
                notifications[index].post = try await PostService.fetchPost(uid: notification.postID ?? "")
            }
        }
        return notifications
    }
    
    static func addNotification(targetUserID: String, post: Post?, notificationType: NotificationType) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let documentID = FirestoreConstants.notificationsCollection.document().documentID
        var notification: Notification?
        
        if targetUserID != currentUid {
            switch notificationType {
            case .follow:
                notification = Notification(id: documentID, notificationTypeString: notificationType.rawValue, timestamp: Timestamp(), ownerID: currentUid, targetID: targetUserID)
            default:
                guard let post else { return }
                notification = Notification(id: documentID, notificationTypeString: notificationType.rawValue, timestamp: Timestamp(), ownerID: currentUid, targetID: targetUserID, postID: post.id)
            }
        }
        guard let notification, let encodedData = try? Firestore.Encoder().encode(notification) else { return }
        //notifications -> id -> notifications from actions toward that user
        //TODO: Fix later
        try await FirestoreConstants.notificationsCollection.document(notification.id).setData(encodedData)
    }
    
    //TODO: Remove the already existing notification with a specific id
    static func removeNotification(notification: Notification) {
        
    }
}
