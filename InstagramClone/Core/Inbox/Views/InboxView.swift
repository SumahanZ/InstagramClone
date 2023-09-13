//
//  InboxView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView: Bool = false

    var body: some View {
        ScrollView {
            List {
                ForEach(DeveloperPreview.MOCK_USERS) { user in
                        InboxRowView(user: user)
                }
            }
            .listStyle(PlainListStyle())
            //when we put list in a scrollview we need to give an explicit height
            .frame(height: UIScreen.main.bounds.height)
        }
        .navigationTitle("Messages")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showNewMessageView, content: {
            NewMessageView(showNewMessageView: $showNewMessageView)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showNewMessageView.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                .tint(.black)

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
