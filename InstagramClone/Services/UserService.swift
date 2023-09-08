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
    private static let usersCollection = Firestore.firestore().collection("users")

    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await usersCollection.getDocuments()
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
        let snapshot = try await usersCollection.document(uid).getDocument()
        let currentUser = try snapshot.data(as: User.self)
        return currentUser
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
        var followers: [User] = []
        for uid in user.followers {
            let follower = try await UserService.fetchUser(uid: uid)
            followers.append(follower)
        }
        return followers
    }

    static func fetchFollowingUser(user: User) async throws -> [User] {
        var followings: [User] = []
        for uid in user.following {
            let following = try await UserService.fetchUser(uid: uid)
            followings.append(following)
        }
        return followings
    }
}
