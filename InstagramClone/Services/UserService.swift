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
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        /*
         The swift way of doing tempUsers for user in users, more clean and shorter
         We use compactMap incase we can't decode a user data, therefore we won't put that data in the final array.
         */
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}
