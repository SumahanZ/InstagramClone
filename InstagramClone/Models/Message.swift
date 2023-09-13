//
//  Message.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Codable, Hashable {
    let id: String
    let fromUid: String
    let toUid: String
    let messageText: String
    let timestamp: Timestamp
    var user: User?

    var chatPartnerId: String {
        return fromUid == Auth.auth().currentUser?.uid ? toUid : fromUid
    }

    var isFromCurrentUser: Bool {
        return fromUid == Auth.auth().currentUser?.uid
    }
}
