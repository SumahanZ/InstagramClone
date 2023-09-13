//
//  NewMessageView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import SwiftUI

struct NewMessageView: View {
    @StateObject private var newMessageVM = NewMessageViewModel()
    @State private var searchText = ""
    @Binding var showNewMessageView: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 17) {
                Text("To ")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Search", text: $searchText)
                
                Text("Users")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(15)
            
            LazyVStack {
                ForEach(newMessageVM.availableUsers) { user in
                    UserRow(user: user)
                    Divider()
                        .padding(.leading, 40)
                }
            }
            
        }
        .navigationTitle("New Message")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss.callAsFunction()
                }
                .tint(.black)
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewMessageView(showNewMessageView: .constant(true))
        }
    }
}
