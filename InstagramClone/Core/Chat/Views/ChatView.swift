//
//  ChatView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatVM: ChatViewModel
    let user: User

    init(user: User) {
        self.user = user
        _chatVM = StateObject(wrappedValue: ChatViewModel(user: user))
    }

    var body: some View {
        ScrollViewReader { reader in
            VStack {
                ScrollView {
                    VStack {
                        CircularProfileImageView(user: user, size: .large)

                        VStack(spacing: 4){
                            Text(user.username)
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("Instagram")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }

                    //messages
                    LazyVStack(spacing: 20) {
                        ForEach(chatVM.messages) { message in
                            ChatMessageCell(message: message)
                        }
                    }
                    .onChange(of: chatVM.messages) { newValue in
                        print(chatVM.messages)
                        if let lastMessage = chatVM.messages.last {
                            withAnimation {
                                reader.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }

                Spacer()

                ZStack(alignment: .trailing) {
                    TextField("Message...", text: $chatVM.messageText, axis: .vertical)
                        .padding(15)
                        .padding(.trailing, 48)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(Capsule())
                        .font(.subheadline)

                    Button {
                        Task {
                            try? await chatVM.sendMessage()
                            chatVM.messageText = ""
                        }
                    } label: {
                        Text("Send")
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)

                }
                .padding()
            }
            .navigationTitle("\(user.username)")
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: DeveloperPreview.MOCK_USERS[0])
    }
}
