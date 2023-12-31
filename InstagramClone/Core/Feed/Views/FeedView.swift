//
//  FeedView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var feedVM = FeedViewModel()
    @State private var selectedPost: Post?
    @State private var showInboxView: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(feedVM.posts) { post in
                        FeedCell(selectedPost: $selectedPost, post: post, userID: feedVM.currentUserID)
                            .environmentObject(feedVM)
                    }
                }
                .padding(.top, 8)
            }
            .refreshable {
                Task { try? await feedVM.fetchPosts() }
            }
            .sheet(isPresented: $showInboxView, content: {
                InboxView()
            })
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("instagram_logo_black")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 32)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                        .onTapGesture {
                            showInboxView.toggle()
                        }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
