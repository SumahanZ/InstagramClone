//
//  InboxView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import SwiftUI

struct InboxView: View {
    @State private var selectedUser: User?
    @State private var selectedMessage: Message?
    @State private var showNewMessageView: Bool = false
    @State private var showChat = false
    @StateObject private var inboxVM = InboxViewModel()

    var body: some View {
        NavigationStack {
            //apple doesnt recommend putting list in scrollview then setting a specific height
            List {
                ForEach(inboxVM.recentMessages) { message in
                    /*
                     Work around, because when we put navigationlink in list it will show a right chevron
                     */
                    ZStack {
                        NavigationLink(value: message) {
                            EmptyView()
                        }
                        .opacity(0.0)

                        InboxRowView(message: message)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
            /*
             when we put list in a scrollview we need to give an explicit height
             */
            .onChange(of: selectedUser, perform: { newValue in
                /*
                 if the selectedUser value changes, we want the showChat to be true
                 */
                showChat = newValue != nil
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
            .navigationDestination(isPresented: $showChat, destination: {
                /*
                 if selectedUser is not null, then we can navigate to chatview (we need a user object and it can't be null)
                 */
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            /*
             The reason we don't navigate from the newmessageview is because it is a sheet and generally sheets as a best practice should not be nested, we should navigate from views not sheets
             */
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        /*
                         The reason the bug was happening it was because of the selectedUser onChange, so if we select the same user in a row it won't trigger the showchatview toggle, therefore we have to set it to nil again before being able to navigate to the same user again
                         */
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    .tint(.black)

                }
            }
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InboxView()
        }
    }
}
