//
//  UserService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 04/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
/*
 Generic service, can be used in multiple places Service in the folder in the core can only be used in a specific place
 */
class UserService {
    
    static func fetchAllUsers() async throws -> [User] {
        var tempUsers: [User] = []
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        for doc in snapshot.documents {
            let user = try doc.data(as: User.self)
            tempUsers.append(user)
        }
        return tempUsers
    }
}
