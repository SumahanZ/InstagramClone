//
//  ChatViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 14/09/23.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
    @Published var messages: [Message] = []
    //Dependency Injection
    private let service: ChatService
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User) {
        service = ChatService(chatPartner: user)
        setupSubscribers()
        //observeMessages()
    }

    func setupSubscribers() {
        service.$messages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] messages in
                self?.messages.append(contentsOf: messages)
            }
            .store(in: &cancellables)
    }
    
    func sendMessage() async throws {
        try await service.sendMessage(messageText: messageText)
    }
    
    //    func observeMessages() {
    //        //using the messages variable from the MessageService
    //        service.observeMessages() { messages in
    //            self.messages.append(contentsOf: messages)
    //        }
    //    }
}
