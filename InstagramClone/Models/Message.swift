//
//  Message.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import Firebase

struct Message: Identifiable, Codable, Hashable {
    let id: String
    let fromUid: String
    let toUid: String
    let messageText: String
    let timestamp: Timestamp
    
    var user: User?

    var chatPartnerId: String {
        /*
         this will help us figure out who we are chatting with. If the message comes from this device, then we are chatting with the person the message is to, but if the message comes not from this device therefore the chatPartner is the fromUid
         */
        return fromUid == Auth.auth().currentUser?.uid ? toUid : fromUid
    }

    //the logic to differentiate the chat bubbles who is sending the message from us or from the partner
    var isFromCurrentUser: Bool {
        return fromUid == Auth.auth().currentUser?.uid
    }

    var timestampString: String {
        return timestamp.dateValue().timeStampString()
    }
}
