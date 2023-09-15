//
//  ChatService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 14/09/23.
//

import Foundation

//
//  MessageService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import Firebase

class ChatService {
    @Published var messages: [Message] = []
    let chatPartner: User
    
    init(chatPartner: User) {
        self.chatPartner = chatPartner
        observeMessages()
    }
    
    func sendMessage(messageText: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.messagesCollection.document(currentUid).collection(chatPartnerId)
        let chatPartnerRef = FirestoreConstants.messagesCollection.document(chatPartnerId).collection(currentUid)
        let recentCurrentUserRef = FirestoreConstants.messagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
        let recentPartnerUserRef = FirestoreConstants.messagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)
        /*
         this is .document(), it creates a document and we only want to create 1 messageID to 2 users. For example if i was sending from the user batman, it will set a document of messageId, but we need to also add it in the joker as well, by referencing the same document from the messageId
         */
        let messageId = currentUserRef.document().documentID
        let message = Message(id: messageId, fromUid: currentUid, toUid: chatPartnerId, messageText: messageText, timestamp: Timestamp())
        //When you send a message you need to add it in 2 places at once
        guard let encodedMessageData = try? Firestore.Encoder().encode(message) else { return }
        //add the message in two places
        try await currentUserRef.document(messageId).setData(encodedMessageData)
        try await chatPartnerRef.document(messageId).setData(encodedMessageData)
        
        try await recentCurrentUserRef.setData(encodedMessageData)
        try await recentPartnerUserRef.setData(encodedMessageData)
    }
    
    //we are not using async throws here,
    func observeMessages() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        /*
         Go to the currently logged in user, find their chat partner id (who they are having a conversation with now, order the messages by timestamp
         */
        let query = FirestoreConstants.messagesCollection
            .document(currentUid)
            .collection(chatPartner.id)
            .order(by: "timestamp", descending: false)
        //to use snapshotlistener we can't use async await
        /*
         We are adding a snapshotlistener to the collection, so everytime a document gets added to this particular collection in our database, it is going to send that notification to our application and give it the data that it needs right away, that is how we get that real time chat feature.
         */
        query.addSnapshotListener { [weak self] snapshot, _ in
            /*
             listen for added documents
             listen for removed documents
             listen for modified documents
             */
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            /*
             decode the incoming data which are the messages from the partner, which here doesn't have a user object yet, we need user object because it will be crucial for displaying the partnerImage profile
             */
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where message.fromUid != currentUid {
                messages[index].user = self?.chatPartner
            }
            /*
             in the completion we will be passing a function that takes in messages from this function as a parameter
             //so basically when the task is finished we will have a function that runs that has the completed data (the data message we fetched). We dont have a return here because we will be using an escaping closure with a completion and the value will be passed from there
             */
            self?.messages = messages
        }
    }
    
}
