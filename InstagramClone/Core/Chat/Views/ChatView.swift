//
//  ChatView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    var body: some View {
        VStack {
            ScrollView {
                //header
                VStack {
                    CircularProfileImageView(user: DeveloperPreview.MOCK_USERS[0], size: .large)

                    VStack(spacing: 4){
                        Text("Bruce Wayne")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text("Instagram")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }

                //messages
                LazyVStack(spacing: 20) {
                    ForEach(0...5, id: \.self) { message in
                        ChatMessageCell(isFromCurrentUser: Bool.random())
                    }
                }
            }

            Spacer()
            //message input view
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $messageText, axis: .vertical)
                    .padding(15)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)

                Button {
                    //
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)

            }
            .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
