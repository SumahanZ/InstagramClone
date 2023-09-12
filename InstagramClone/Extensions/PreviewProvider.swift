//
//  PreviewProvider.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import Firebase
import Foundation
import SwiftUI

class DeveloperPreview {
    private init() {}

    static let MOCK_USERS: [User] = [
        .init(id: UUID().uuidString, username: "batman", email: "batman@gmail.com", profileImageUrl: nil, fullName: "Bruce Wayne", bio: "Gotham's Dark Knight"),
        .init(id: UUID().uuidString, username: "venom", email: "venom@gmail.com", profileImageUrl: nil, fullName: "Eddie Brock", bio: "Venom"),
        .init(id: UUID().uuidString, username: "ironman", email: "ironman@gmail.com", profileImageUrl: nil, fullName: "Tony Stark", bio: "I am Ironman"),
        .init(id: UUID().uuidString, username: "blackpanther", email: "chadwick@gmail.com", profileImageUrl: nil, fullName: "Chadwick Boseman", bio: "Wakanda Forever"),
        .init(id: UUID().uuidString, username: "spiderman", email: "spiderman@gmail.com", profileImageUrl: nil, fullName: "Peter Parker", bio: "Friendly Neighborhood Spiderman")
    ]

    static let MOCK_POSTS: [Post] = [
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "This is some test caption for now", likes: 123, imageUrl: "batman", timeStamp: Timestamp(), user: MOCK_USERS[0]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "Wakanda Forever", likes: 104, imageUrl: "blackpanther", timeStamp: Timestamp(), user: MOCK_USERS[3]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "I am Ironman", likes: 12, imageUrl: "ironman", timeStamp: Timestamp(), user: MOCK_USERS[2]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "Venom is hungry. Time to eat", likes: 314, imageUrl: "venom", timeStamp: Timestamp(), user: MOCK_USERS[1]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "Spider the spiderman", likes: 76, imageUrl: "spiderman", timeStamp: Timestamp(), user: MOCK_USERS[1])
    ]

    static let MOCK_COMMENTS: [Comment] = [
        .init(id: UUID().uuidString, content: "This post is so cool!", ownerUid: UUID().uuidString, timeStamp: Timestamp(), postUid: UUID().uuidString, commentLikers: [], user: MOCK_USERS[1]),
        .init(id: UUID().uuidString, content: "Nice post man!", ownerUid: UUID().uuidString, timeStamp: Timestamp(), postUid: UUID().uuidString, commentLikers: [], user: MOCK_USERS[2])
    ]

    static let MOCK_NOTIFICATIONS: [Notification] = [
        .init(id: UUID().uuidString, notificationTypeString: "like", timestamp: Timestamp(), ownerID: UUID().uuidString, targetID: nil, postID: UUID().uuidString, notificationType: .like, user: MOCK_USERS[0], post: MOCK_POSTS[1]),
        .init(id: UUID().uuidString, notificationTypeString: "like", timestamp: Timestamp(), ownerID: UUID().uuidString, targetID: nil, postID: UUID().uuidString, notificationType: .like, user: MOCK_USERS[1], post: MOCK_POSTS[0]),
        .init(id: UUID().uuidString, notificationTypeString: "comment", timestamp: Timestamp(), ownerID: UUID().uuidString, targetID: nil, postID: UUID().uuidString, notificationType: .comment, user: MOCK_USERS[1], post: MOCK_POSTS[1]),
        .init(id: UUID().uuidString, notificationTypeString: "follow", timestamp: Timestamp(), ownerID: UUID().uuidString, targetID: MOCK_USERS[1].id, postID: UUID().uuidString, notificationType: .follow, user: MOCK_USERS[2], post: nil)
    ]
    
    static let registrationVMPreview = RegistrationViewModel()
}

