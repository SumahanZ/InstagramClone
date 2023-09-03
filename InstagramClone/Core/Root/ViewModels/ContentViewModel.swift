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
    /*
     ContentViewModel knows nothing about the registration stuff that is happening, it is only listening to the changes of the userSession which indicates if a user is login (shows MainTabView) or not (shows LoginView) through the setupSubscribers function
     */
    @Published var userSession: FirebaseAuth.User?

    init() {
        setupSubscribers()
    }
    /*
     In firebaseauth, firestore, you can't listen to updates when you add or change the data (userSession in this case) in your app using async/await, but we can do it using completion handlers, in this case using Combine
     */
    func setupSubscribers() {
        /*
         UserSession is getting its value in the background thread (async) therefore we need to set the viewmodel userSession with the value from the manager by receiving it first in the main thread
         */
        manager.$userSession
            //.receive(on: DispatchQueue.main)
            .sink { [weak self] session in
                self?.userSession = session
            }
            .store(in: &cancellables)
    }
}
