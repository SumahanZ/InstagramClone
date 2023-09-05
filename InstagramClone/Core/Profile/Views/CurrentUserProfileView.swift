//
//  CurrentUserProfileView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ProfileHeaderView(user: user)
                PostGridView(user: user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        try? AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                    
                }
            }
        }
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: DeveloperPreview.MOCK_USERS[2])
    }
}
