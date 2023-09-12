//
//  NotificationView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 11/09/23.
//

import SwiftUI

struct NotificationView: View {
    @StateObject private var notificationVM: NotificationViewModel = NotificationViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(notificationVM.notifications) { notification in
                        NotificationRowView(notification: notification)
                    }
                }
            }
            .onAppear {
                Task { try? await notificationVM.fetchNotificationsUser() }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
