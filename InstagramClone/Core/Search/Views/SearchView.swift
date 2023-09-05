//
//  SearchView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var searchVM = SearchViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(searchVM.users) { user in
                        NavigationLink(value: user) {
                            SearchUserRow(user: user)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
