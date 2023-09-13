//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 12/09/23.
//

import Foundation
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []

    @MainActor
    func fetchNotificationsUser() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        notifications = try await NotificationService.fetchNotifications(uid: currentUid)
    }

    @MainActor
    func changeFollowersState(notification: Notification) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid, let user = notification.user else { return }
        let currentUser = try await UserService.fetchUser(uid: currentUid)
        let tempUser: User
        var followers = user.followers
        var following = currentUser.following

        if !user.isCurrentUser && user.followers.contains(currentUid) {
            followers.removeAll(where: ({ $0 == currentUid }))
            following.removeAll(where: ({ $0 == user.id }))

        } else {
            followers.append(currentUid)
            following.append(user.id)
            try await NotificationService.addNotification(targetUserID: user.id, post: nil, notificationType: .follow)
        }

        tempUser = user.updateFields(id: nil, username: nil, email: nil, profileImageUrl: nil, fullName: nil, bio: nil, following: nil, followers: followers)
        let currentUserData = currentUser.updateFields(id: nil, username: nil, email: nil, profileImageUrl: nil, fullName: nil, bio: nil, following: following, followers: nil)
        guard let index = notifications.firstIndex(where: ({ $0.id == notification.id })) else { return }
        /*
         Sending updated data to the backend and we should also update the UI, because if we don't update the UI, it is going to update only the backend and the UI is only gonna change once we fetch the data again from the backend. Therefore to maintain a smooth user experience we must update the UI also, if we are going to update the backend of a data for example liking or unliking a post/follow or unfollowing a user (we don't want to refresh to fetch updated data (takes two steps), if we instantly click a button (like button) it updates immediately (takes one step)
         */
        notifications[index].user = tempUser
        guard let encodedDataTargetUser = try? Firestore.Encoder().encode(tempUser), let encodedDataCurrentUser = try? Firestore.Encoder().encode(currentUserData) else { return }
        try await Firestore.firestore().collection("users").document(user.id).updateData(encodedDataTargetUser)
        try await Firestore.firestore().collection("users").document(currentUid).updateData(encodedDataCurrentUser)
    }
}
