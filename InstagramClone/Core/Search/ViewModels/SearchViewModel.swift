//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 04/09/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users: [User] = []

    @MainActor
    func fetchAllUsers() async throws {
        users = try await UserService.fetchAllUsers()
    }
}
