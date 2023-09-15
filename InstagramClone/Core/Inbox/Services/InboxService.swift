//
//  InboxService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 14/09/23.
//

import Foundation
import Firebase

class InboxService {
    /*
     We will be handling the mapping into a message object in the viewmodel because it can get quite complicated and the dealing of UI is related to the viewmodel. We are only giving the viewmodel the data that it needs and then the viewmodel can go use that data to update the view accordingly
     */
    @Published var documentChanges = [DocumentChange]()

    init() {
        observeRecentMessages()
    }

    func observeRecentMessages() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let query = FirestoreConstants.messagesCollection
            .document(currentUid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        /*
         listen to any document changes of the recent-messages collection of a specific user, so basically when the document changes (Added/modified) in the collection it will return the data back
         */
        query.addSnapshotListener { [weak self] snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified }) else { return }

            self?.documentChanges = changes
        }
    }

//    func observeRecentMessage(completion: @escaping(([DocumentChange]) -> Void)) {
//        guard let currentUid = Auth.auth().currentUser?.uid else { return }
//        let query = FirestoreConstants.messagesCollection
//            .document(currentUid)
//            .collection("recent-messages")
//            .order(by: "timestamp", descending: true)
//        /*
//         listen to any document changes of the recent-messages collection of a specific user, so basically when the document changes (Added/modified) in the collection it will return the data back
//         */
//        query.addSnapshotListener { [weak self] snapshot, _ in
//            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified }) else { return }
//
//            self?.documentChanges = changes
//        }
//    }
}
