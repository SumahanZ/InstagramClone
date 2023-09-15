//
//  NewMessageView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import SwiftUI

struct NewMessageView: View {
    @StateObject private var newMessageVM = NewMessageViewModel()
    @Binding var selectedUser: User?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 17) {
                    Text("To ")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Search", text: $newMessageVM.searchText)
                    
                    Text("Users")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(15)
                
                ForEach(newMessageVM.availableUsers) { user in
                    VStack {
                        UserRow(user: user)
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss.callAsFunction()
                    }
                }
                
                
            }
            .onChange(of: newMessageVM.searchText, perform: { _ in
                newMessageVM.filterUsers()
            })
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss.callAsFunction()
                        selectedUser = nil
                    }
                    .tint(.black)
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewMessageView(selectedUser: .constant(DeveloperPreview.MOCK_USERS[0]))
        }
    }
}
