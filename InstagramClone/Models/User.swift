//
//  User.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let username: String
    let email: String
    let profileImageUrl: String?
    let fullName: String?
    let bio: String?

    func updateFields(id: String?, username: String?, email: String?, profileImageUrl: String?, fullName: String?, bio: String?) -> User {
        return User(id: id ?? self.id, username: username ?? self.username, email: email ?? self.email, profileImageUrl: profileImageUrl ?? self.profileImageUrl, fullName: fullName ?? self.fullName, bio: bio ?? self.bio)
    }
}

