//
//  FollowButton.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 11/09/23.
//

import SwiftUI
import Firebase

struct FollowButton: View {
    let notification: Notification
    
    var isFollower: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid, let user = notification.user else { return false }
        return !user.isCurrentUser && user.followers.contains(currentUid) ? true : false
    }
    
    var body: some View {
        Text(isFollower ? "Following" : "Follow")
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(isFollower ? .black : .white)
            .padding(.vertical, 7)
            .padding(.horizontal, 15)
            .background(isFollower ? Color.clear : Color.blue)
            .cornerRadius(6)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(isFollower ? .gray : .clear, lineWidth: 1)
            }
            .animation(.easeInOut, value: isFollower)
        
    }
}

struct FollowButton_Previews: PreviewProvider {
    static var previews: some View {
        FollowButton(notification: DeveloperPreview.MOCK_NOTIFICATIONS[0])
    }
}
