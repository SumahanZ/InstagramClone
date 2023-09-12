//
//  NotificationRow.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 11/09/23.
//

import SwiftUI

struct NotificationRowView: View {
    let notification: Notification
    
    var body: some View {
        HStack(alignment: .center) {
            if let user = notification.user {
                CircularProfileImageView(user: user, size: .xSmall)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                /*
                 + adding plus combines the individual views and make it line up together. The lining up together will be based on the size of the container in this case the HStack
                 */
                HStack {
                    if let username = notification.user?.username, let type = notification.notificationType {
                        Text("\(username) ")
                            .fontWeight(.semibold) +
                        Text(type == .comment ? "commented on a post" : type == .like ? "liked one of your posts" : "started following you")
                        
                    }
                }
                .font(.caption)
                .frame(maxWidth: UIScreen.main.bounds.width * (notification.notificationType == .follow ? 0.4 : 0.5), alignment: .leading)
            }
            .font(.caption2)
            
            Spacer()
            
            if let type = notification.notificationType {
                switch type {
                case .follow:
                    FollowButton()
                default:
                    if let post = notification.post {
                        RectangleNotificationImagePostView(post: post, size: .xSmall)
                    }
                }
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

struct NotificationRowView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRowView(notification: DeveloperPreview.MOCK_NOTIFICATIONS[3])
            .previewLayout(.sizeThatFits)
    }
}
