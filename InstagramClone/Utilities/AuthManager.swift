//
//  AuthenticationService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

enum AuthError: LocalizedError {
    case badRegistration, badLogin(email: String, password: String)

    var errorDescription: String? {
        switch self {
        case .badLogin(let email, let password):
            return "Failed to login with the given user credentials of Username: \(email) and Password: \(password)!"
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

    @MainActor
    func login(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
        } catch {
            throw AuthError.badLogin(email: email, password: password)
        }
    }

    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            await uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            throw AuthError.badRegistration
        }

    }

    func loadUserData() async throws {

    }
    
    func signOut() throws {
        do {
            /*
             when we are calling this signout function from firebase we are not yet updating the userSession which manages the front end of whether the user is login (shows MainTabView) or not (shows LoginView) unless we set userSession to nil
             */
            try Auth.auth().signOut()
            userSession = nil
        } catch let error {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
    /*
     We typically don't use throw when uploading data because that rearely ever goes wrong and we don't handle the error
     */
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        /*
         try to Encode the UserModel into Data that can be stored in the FirestoreFirebase we make it guard let because the encoding can fail
         */
        guard let encodedUserData = try? Firestore.Encoder().encode(user) else { return }
    }
}
