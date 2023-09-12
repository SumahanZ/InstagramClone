//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 12/09/23.
//

import Foundation
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []

    @MainActor
    func fetchNotificationsUser() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        notifications = try await NotificationService.fetchNotifications(uid: currentUid)
    }
}
