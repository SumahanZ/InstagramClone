//
//  InboxViewModek.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 14/09/23.
//

import Foundation
import Firebase
import Combine

class InboxViewModel: ObservableObject {
    @Published var recentMessages: [Message] = []
    private let service = InboxService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
        //loadInitialMessages()
    }
    
    private func setupSubscribers() {
        /*
         we are using combine here because we are dealing with real time data, and we want to update the ui as soon as a change happens/ also doable using completionhandlers/ but we cant do this using async await
         */
        service.$documentChanges
            .receive(on: DispatchQueue.main)
            .sink { [weak self] documentChanges in
                self?.loadInitialMessages(documents: documentChanges)
            }
            .store(in: &cancellables)
    }
    //    private func loadInitialMessages() {
    //        service.observeRecentMessages { [weak self] documentChanges in
    //            var messages = documentChanges.compactMap({ try? $0.document.data(as: Message.self) })
    //
    //            for (index, _) in messages.enumerated() {
    //                let message = messages[index]
    //
    //                UserService.fetchUserCompletion(uid: message.chatPartnerId) { user in
    //                    messages[index].user = user
    //                    self?.recentMessages = messages
    //                }
    //            }
    //        }
    //    }
    private func loadInitialMessages(documents: [DocumentChange]) {
        var messages = documents.compactMap({ try? $0.document.data(as: Message.self) })
        
        for (index, _) in messages.enumerated() {
            UserService.fetchUserCompletion(uid: messages[index].chatPartnerId) { [weak self] user in
                messages[index].user = user
                let partnerID = messages[index].chatPartnerId
                // Check if there is a recent message with the specified partner, if there is we replace that recent message with the new one, but if not we add to the recentMessage array (Other conversations)
                if let recentMessageWithSpecificPartnerIndex = self?.recentMessages.firstIndex(where: { $0.chatPartnerId == partnerID }) {
                    // Replace the previous recent message with the new one
                    self?.recentMessages[recentMessageWithSpecificPartnerIndex] = messages[index]
                } else {
                    // Add the new recent message if it doesn't exist in the recentMessages (other conversations)
                    self?.recentMessages.append(messages[index])
                }
            }
        }
    }
}
