//
//  RegistrationViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 02/09/23.
//

import Foundation
/*
 We are going through a flow in the registration and we need information for each signup flow screen. Therefore we need some sort of container to hold these information (We need to keep track of all the information) without having to pass it in from one signup flow screen to another signup flow screen.
 */
/*
 use the shared instance from authservice because we are gonna refer to the same AuthService.instance
 */
class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    private let manager = AuthManager.shared

    func createUser() async throws {
        try await manager.createUser(email: email, password: password, username: username)
    }
}
