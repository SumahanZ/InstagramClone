//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 05/09/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []

    init() {
        Task { try? await fetchPosts() }
    }

    @MainActor
    func fetchPosts() async throws {
        posts = try await PostService.fetchPosts()
    }
}
