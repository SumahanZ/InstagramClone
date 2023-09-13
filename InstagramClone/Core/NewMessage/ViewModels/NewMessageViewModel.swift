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

    init() {
        Task { try? await fetchAllAvailableUsers() }
    }
    
    @MainActor
    func fetchAllAvailableUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.availableUsers = users.filter({ $0.id != currentUid })
    }
}
