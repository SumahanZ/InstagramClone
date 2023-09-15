//
//  NewMessageViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import Firebase

class NewMessageViewModel: ObservableObject {
    @Published var availableUsers: [User] = []
    @Published var searchText = ""
    private var fetchedUsers: [User] = []

    init() {
        Task { try? await fetchAllAvailableUsers() }
    }
    
    @MainActor
    func fetchAllAvailableUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        fetchedUsers = users.filter({ $0.id != currentUid })
        availableUsers = users.filter({ $0.id != currentUid })
    }
    
    func filterUsers() {
        let lowercaseText = searchText.lowercased()
        availableUsers = fetchedUsers
        if !searchText.isEmpty {
            availableUsers = availableUsers.filter({ $0.username.lowercased().contains(lowercaseText) })
        }
    }
}
