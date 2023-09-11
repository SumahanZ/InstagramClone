//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 05/09/23.
//

import FirebaseFirestore
import Foundation
import Firebase
import FirebaseAuth

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var currentUserID: String
    
    init() {
        currentUserID = Auth.auth().currentUser?.uid ?? ""
        Task { try? await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws {
        posts = try await PostService.fetchPosts()
    }

    @MainActor
    func updateLikes(post: Post) async throws {
        var postLikers = post.postLikers
        var selectedPost: Post?
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        if postLikers.contains(currentUID) {
            postLikers.removeAll(where: { $0 == currentUID })
            selectedPost = post.updateFields(id: nil, ownerUid: nil, caption: nil, likes: post.likes - 1, imageUrl: nil, timeStamp: nil, postLikers: postLikers)
        } else {
            postLikers.append(currentUID)
            selectedPost = post.updateFields(id: nil, ownerUid: nil, caption: nil, likes: post.likes + 1, imageUrl: nil, timeStamp: nil, postLikers: postLikers)
        }
        
        guard let index = posts.firstIndex(where: ({ $0.id == post.id })), let selectedPost else { return }
        posts[index] = selectedPost
        posts[index].user = post.user
        guard let encodedData = try? Firestore.Encoder().encode(selectedPost) else { return }
        try await Firestore.firestore().collection("posts").document(post.id).updateData(encodedData)
    }
}
