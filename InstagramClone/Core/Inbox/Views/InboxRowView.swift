//
//  InboxRowView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import SwiftUI

struct InboxRowView: View {
    let message: Message
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if let user = message.user {
                    CircularProfileImageView(user: user, size: .small)
                }

                VStack(alignment: .leading, spacing: 5) {
                    if let username = message.user?.username {
                        Text("\(username)")
                            .fontWeight(.semibold)
                    }

                    Text("\(message.messageText)")
                        .lineLimit(2)
                        .font(.caption)
                        .foregroundColor(Color.black.opacity(0.4))
                    //if we don;t set frame, it is going to only be as big as its content
                        .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)

                }
                .font(.subheadline)

                HStack {
                    Text("\(message.timestampString)")
                    Image(systemName: "chevron.right")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            .frame(height: 72)

            Divider()
                .padding(.leading, 53)
        }
    }
}

//struct InboxRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        InboxRowView(user: DeveloperPreview.MOCK_USERS[2])
//    }
//}
