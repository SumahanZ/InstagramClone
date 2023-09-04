//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 04/09/23.
//

import Foundation

class SearchViewModel {
    @Published var users: [User] = []

    init() {
        Task { try? await fetchAllUsers() }
    }

    func fetchAllUsers() async throws {
        users = try await UserService.fetchAllUsers()
    }
}
