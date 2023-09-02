//
//  ContentViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 02/09/23.
//

import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    private let manager = AuthManager.shared
    private var cancellables = Set<AnyCancellable>()

    @Published var userSession: FirebaseAuth.User?

    init() {
        setupSubscribers()
    }
    /*
     In firebaseauth, firestore, you can't listen to updates when you add or change the data (userSession in this case) in your app using async/await, but we can do it using completion handlers, in this case using Combine
     */
    func setupSubscribers() {
        manager.$userSession
            .sink { [weak self] session in
                self?.userSession = session
            }
            .store(in: &cancellables)
    }
}
