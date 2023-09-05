//
//  PostGridViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 05/09/23.
//

import Foundation

class PostGridViewModel: ObservableObject {
    /*
     All posts of a specific user
     */
    @Published var posts: [Post] = []
    private let user: User

    init(user: User) {
        self.user = user
        Task { try? await fetchUserPosts() }
    }

    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(user: user)
    }
}
