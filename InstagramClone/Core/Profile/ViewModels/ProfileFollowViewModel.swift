//
//  ProfileFollowViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 07/09/23.
//

import Foundation

class ProfileFollowViewModel: ObservableObject {
    @Published var followers: [User] = []
    @Published var following: [User] = []
    private let user: User

    init(user: User) {
        self.user = user
        Task {
            try? await fetchFollowersUser()
            try? await fetchFollowingsUser()
        }
    }

    @MainActor
    func fetchFollowersUser() async throws {
        followers = try await UserService.fetchFollowersUser(user: user)
    }

    @MainActor
    func fetchFollowingsUser() async throws {
        following = try await UserService.fetchFollowingUser(user: user)
    }
    
}
