//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import Foundation
import Firebase

class CommentViewModel: ObservableObject {
    private let commentsCollection = Firestore.firestore().collection("comments")
    @Published var comments: [Comment] = []
    @Published var commentContent: String = ""
    private let post: Post

    init(post: Post) {
        self.post = post
    }

    @MainActor
    func fetchCommentsPost() async throws {
        comments = try await CommentService.fetchPostComments(post: post)
    }

    @MainActor
    func addComment(content: String) async throws {
        //TODO: Add comments
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        let commentID = commentsCollection.document().documentID
        let comment = Comment(id: commentID, content: commentContent, ownerUid: currentUserId, timeStamp: Timestamp(), postUid: post.id)
        guard let encodedData = try? Firestore.Encoder().encode(comment) else { return }
        try await Firestore.firestore().collection("comments").document(comment.id).setData(encodedData)
    }
}
