//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import FirebaseFirestore
import Foundation
import Firebase

class CommentViewModel: ObservableObject {
    private let commentsCollection = Firestore.firestore().collection("comments")
    @Published var comments: [Comment] = []
    @Published var commentContent: String = ""
    private let post: Post
    
    init(post: Post) {
        self.post = post
        Task { try? await fetchCommentsPost() }
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
        var comment = Comment(id: commentID, content: commentContent, ownerUid: currentUserId, timeStamp: Timestamp(), postUid: post.id)
        guard let encodedData = try? Firestore.Encoder().encode(comment) else { return }
        try await Firestore.firestore().collection("comments").document(comment.id).setData(encodedData)
        comment.user = post.user
        self.comments.append(comment)
        print("Entered in comment here")
    }
    
    @MainActor
    func commentChangeLikeState(comment: Comment) async throws {
        var commentLikers = comment.commentLikers
        var selectedComment: Comment?
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        if commentLikers.contains(currentUserId) {
            commentLikers.removeAll(where: { $0 == currentUserId })
        } else {
            commentLikers.append(currentUserId)
        }
        
        selectedComment = comment.updateFields(id: nil, content: nil, ownerUid: nil, timeStamp: nil, postUid: nil, commentLikers: commentLikers)
        guard let index = comments.firstIndex(where: ({ $0.id == comment.id })), let selectedComment else { return }
        comments[index] = selectedComment
        comments[index].user = comment.user
        guard let encodedData = try? Firestore.Encoder().encode(selectedComment) else { return }
        try await Firestore.firestore().collection("comments").document(comment.id).updateData(encodedData)
        print("Finished")
    }
}
