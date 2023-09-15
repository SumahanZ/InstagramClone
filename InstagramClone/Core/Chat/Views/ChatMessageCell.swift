//
//  ChatMessageCell.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import SwiftUI

struct ChatMessageCell: View {
    //If it is from the current user it shows the green chat bubble and if the message is from the other user it shows a gray chat bubble with a profile image
    //let isFromCurrentUser: Bool
    let message: Message

    var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                Text("\(message.messageText)")
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    if let user = message.user {
                        CircularProfileImageView(user: user, size: .xXSmall)
                    }

                    Text("\(message.messageText)")
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

//struct ChatMessageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatMessageCell(isFromCurrentUser: true, message: DeveloperPreview.)
//    }
//}
