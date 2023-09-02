//
//  MainTabView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)

            UploadPostView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "plus.square")
                }
                .tag(2)

            Text("Notifications")
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(3)

            CurrentUserProfileView(user: DeveloperPreview.MOCK_USERS[0])
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(4)
        }
        .tint(.black)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
