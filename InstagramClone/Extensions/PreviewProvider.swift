//
//  PreviewProvider.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import Foundation
import SwiftUI

class DeveloperPreview {
    private init() {}

    static let MOCK_USERS: [User] = [
        .init(id: UUID().uuidString, username: "batman", email: "batman@gmail.com", profileImageUrl: "batman", fullName: "Bruce Wayne", bio: "Gotham's Dark Knight"),
        .init(id: UUID().uuidString, username: "venom", email: "venom@gmail.com", profileImageUrl: "venom", fullName: "Eddie Brock", bio: "Venom"),
        .init(id: UUID().uuidString, username: "ironman", email: "ironman@gmail.com", profileImageUrl: "ironman", fullName: "Tony Stark", bio: "I am Ironman"),
        .init(id: UUID().uuidString, username: "blackpanther", email: "chadwick@gmail.com", profileImageUrl: "blackpanther", fullName: "Chadwick Boseman", bio: "Wakanda Forever"),
        .init(id: UUID().uuidString, username: "spiderman", email: "spiderman@gmail.com", profileImageUrl: "spiderman", fullName: "Peter Parker", bio: "Friendly Neighborhood Spiderman")
    ]

    static let MOCK_POSTS: [Post] = [
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "This is some test caption for now", likes: 123, imageUrl: "batman", timeStamp: .now, user: MOCK_USERS[0]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "Wakanda Forever", likes: 104, imageUrl: "blackpanther", timeStamp: .now, user: MOCK_USERS[3]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "I am Ironman", likes: 12, imageUrl: "ironman", timeStamp: .now, user: MOCK_USERS[2]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "Venom is hungry. Time to eat", likes: 314, imageUrl: "venom", timeStamp: .now, user: MOCK_USERS[1]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, caption: "Spider the spiderman", likes: 76, imageUrl: "spiderman", timeStamp: .now, user: MOCK_USERS[1])
    ]

    static let registrationVMPreview = RegistrationViewModel()
}

