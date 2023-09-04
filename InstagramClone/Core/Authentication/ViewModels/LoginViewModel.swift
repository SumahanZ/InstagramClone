//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 02/09/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    private let manager = AuthService.shared

    func signIn() async throws {
        try await manager.login(email: email, password: password)
    }
}
