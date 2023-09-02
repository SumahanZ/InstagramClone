//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    private var posts: [Post] {
        return DeveloperPreview.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }

    var body: some View {
        /*
         Navigating from a navigationstack to another view that has a navigationstack will cause issues
         */
        ScrollView {
            ProfileHeaderView(user: user)
            PostGridView(posts: posts)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: DeveloperPreview.MOCK_USERS[0])
    }
}
