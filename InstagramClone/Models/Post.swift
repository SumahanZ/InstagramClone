//
//  Post.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import Foundation
import Firebase
/*
 The reason we don't put like user username, imageUrl of the user rightaway is because firebase cant store created model.
 Another reason is because if we were to do this manually we have to change the one in the users as well so there will be two source of truths, it will be straining in the backend we have to change the one in the posts and then in the users. Therefore by only having a uid that will reference to that specific user, we will have one source of truth and whenever a change happens in the users, it will be automatically be reflected in the posts as well.
 The user profile in the posts will always be the most up to date
 */
struct Post: Identifiable, Codable, Hashable {
    let id: String
    let ownerUid: String
    let caption: String
    let likes: Int
    let imageUrl: String
    //we use Timestamp object because firebase doesn't accept Date object to be put in FireStore
    let timeStamp: Timestamp
    var user: User?
}
