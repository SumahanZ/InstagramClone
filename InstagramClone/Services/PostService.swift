//
//  PostService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 05/09/23.
//

import Foundation
import Firebase

class PostService {
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchPosts() async throws -> [Post] {
        let snapshot = try await postsCollection.getDocuments()
        var posts = snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
        /*
         We need to do this because if we use for post in posts, the post is made as a let constant
         */
        for (index, _) in posts.enumerated() {
            let postUser = try await UserService.fetchUser(uid: posts[index].ownerUid)
            posts[index].user = postUser
        }
        return posts
    }
    /*
     we don't have to fetch the user here again because we get a parameter of let user: User from the ProfileView from the navigationdestination in SearchView
     */
    static func fetchUserPosts(user: User) async throws -> [Post] {
        //Fetch Request on fetch post which has the ownerUid the same as the uid being passed in the parameter
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: user.id).getDocuments()
        var posts = snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
        
        for (index, _) in posts.enumerated() {
            posts[index].user = user
        }
        return posts
    }

    static func fetchPost(uid: String) async throws -> Post {
        let snapshot = try await postsCollection.document(uid).getDocument()
        let post = try snapshot.data(as: Post.self)
        return post
    }
}
