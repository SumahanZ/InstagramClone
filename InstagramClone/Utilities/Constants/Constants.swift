//
//  Constants.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 14/09/23.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let usersCollection = Firestore.firestore().collection("users")
    static let messagesCollection = Firestore.firestore().collection("messages")
    static let postsCollection = Firestore.firestore().collection("posts")
    static let commentsCollection = Firestore.firestore().collection("comments")
    static let notificationsCollection = Firestore.firestore().collection("collections")
}
