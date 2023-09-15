//
//  CommentService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 07/09/23.
//

import Foundation
import Firebase

class CommentService {
    static func fetchPostComments(post: Post) async throws -> [Comment] {
        let snapshot = try await FirestoreConstants.commentsCollection.whereField("postUid", isEqualTo: post.id).getDocuments()
        var postComments = snapshot.documents.compactMap({ try? $0.data(as: Comment.self)})

        for (index, _) in postComments.enumerated() {
            postComments[index].user = post.user
        }

        return postComments
    }
}
