//
//  User.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import Foundation
import Firebase

struct User: Identifiable, Codable, Hashable {
    let id: String
    let username: String
    let email: String
    let profileImageUrl: String?
    let fullName: String?
    let bio: String?
    /*
     Let's take at the currentuser id if there isn't one it returns false, but if the id propertu of the User class is the same as the uid we got from firebase using Auth.auth().currentUser?.id, then it will return true, otherwise returns false
     */
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
    
    init(id: String, username: String, email: String, profileImageUrl: String? = nil, fullName: String? = nil, bio: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.fullName = fullName
        self.bio = bio
    }
    
    func updateFields(id: String?, username: String?, email: String?, profileImageUrl: String?, fullName: String?, bio: String?) -> User {
        return User(id: id ?? self.id, username: username ?? self.username, email: email ?? self.email, profileImageUrl: profileImageUrl ?? self.profileImageUrl, fullName: fullName ?? self.fullName, bio: bio ?? self.bio)
    }
}

