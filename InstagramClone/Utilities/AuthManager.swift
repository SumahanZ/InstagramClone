//
//  AuthenticationService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import Foundation
import FirebaseAuth

enum AuthError: LocalizedError {
    case badRegistration, badLogin(username: String, password: String)

    var errorDescription: String? {
        switch self {
        case .badLogin(let username, let password):
            return "Failed to login with the given user credentials of Username: \(username) and Password: \(password)"
        case .badRegistration:
            return "Failed to register with the given inputs!"
        }
    }
}

class AuthManager {
    /*
     The current user session (when user not logged in it will be nil and when the user is logged in the session will not be nil)
     */
    @Published var userSession: FirebaseAuth.User?
    /*
     Shared works like @Stateobject in the case that we only intialize it once as the source of truth or the only is instance it is referring to. Anything else that wants to use it should refer to the shared variable. For example a userSession should only be one thing, therefore we don't want to create many instances of this userSession
     */
    static let shared = AuthManager()

    private init() {
        /*
         Auth.auth().currentUser is a property from firebase that checks whether a user session exist or not determined from the state of the user (logged in or not)
         */
        userSession = Auth.auth().currentUser
    }

    func login(email: String, password: String) async throws {
        
    }

    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            throw AuthError.badRegistration
        }

    }

    func loadUserData() async throws {

    }

    func signOut() {

    }
}
