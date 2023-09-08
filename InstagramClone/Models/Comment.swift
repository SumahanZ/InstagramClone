//
//  Comment.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 07/09/23.
//

import Foundation
import Firebase

struct Comment: Identifiable, Codable, Hashable {
    let id: String
    let content: String
    let ownerUid: String
    let timeStamp: Timestamp
    let postUid: String
    var commentLikers: [String] = []
    //we need this user property when using the circularProfileImage
    let user: User?

    func updateFields(id: String?, content: String?, ownerUid: String?, timeStamp: Timestamp?, postUid: String?, commentLikers: [String]?, user: User?) -> Comment {
        return Comment(id: id ?? self.id, content: content ?? self.content, ownerUid: ownerUid ?? self.ownerUid, timeStamp: timeStamp ?? self.timeStamp, postUid: postUid ?? self.postUid, user: user ?? self.user)
    }
}
