//
//  Notification.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 11/09/23.
//

import Firebase
import Foundation

enum NotificationType: String, Codable {
    case follow, like, comment
}

struct Notification: Identifiable, Codable, Hashable {
    let id: String
    let notificationTypeString: String
    let timestamp: Timestamp
    var ownerID: String
    var targetID: String?
    var postID: String?
    //with var passing it in the init is not a must
    var notificationType: NotificationType?
    var user: User?
    var post: Post?
}
