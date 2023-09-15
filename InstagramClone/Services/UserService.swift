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
        let snapshot = try await FirestoreConstants.usersCollection.getDocuments()
        /*
         The swift way of doing tempUsers for user in users, more clean and shorter
         We use compactMap incase we can't decode a user data, therefore we won't put that data in the final array.
         */
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    static func fetchUser(uid: String) async throws -> User {
        /*
         Find a specific user
         */
        let snapshot = try await FirestoreConstants.usersCollection.document(uid).getDocument()
        let currentUser = try snapshot.data(as: User.self)
        return currentUser
    }
    /*
     we need a fetchUser that doesnt use async/await because snapshotlistener uses completion handlers, and we can't mix the two together
     */
    static func fetchUserCompletion(uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.usersCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
    
    static func fetchLikersPost(postLikers: [String]) async throws -> [User] {
        var users: [User] = []
        for uid in postLikers {
            let likeUser = try await UserService.fetchUser(uid: uid)
            users.append(likeUser)
        }
        return users
    }
    
    static func fetchFollowersUser(user: User) async throws -> [User] {
        let snapshot = try await FirestoreConstants.usersCollection.whereField("following", arrayContains: user.id).getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    static func fetchFollowingUser(user: User) async throws -> [User] {
        let snapshot = try await FirestoreConstants.usersCollection.whereField("followers", arrayContains: user.id).getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}
