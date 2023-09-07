//
//  LikeViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 06/09/23.
//

import Foundation

class LikeViewModel: ObservableObject {
    @Published var postLikers: [User] = []
    private let post: Post
    
    init(post: Post) {
        self.post = post
        Task { try? await fetchPostLikers() }
    }

    @MainActor
    func fetchPostLikers() async throws {
        postLikers = try await UserService.fetchLikersPost(postLikers: post.postLikers)
    }
}
