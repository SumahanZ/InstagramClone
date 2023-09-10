//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import Foundation

class CommentViewModel: ObservableObject {
    private let post: Post
    @Published var comments: [Comment] = []

    init(post: Post) {
        self.post = post
    }

    @MainActor
    func fetchCommentsPost() async throws {
        comments = try await CommentService.fetchPostComments(post: post)
    }
}
