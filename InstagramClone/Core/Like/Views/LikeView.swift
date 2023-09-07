//
//  LikeView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 06/09/23.
//

import SwiftUI

struct LikeView: View {
    @StateObject private var likeVM: LikeViewModel

    init(post: Post) {
        _likeVM = StateObject(wrappedValue: LikeViewModel(post: post))
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(likeVM.postLikers) { user in
                    UserRow(user: user)
                }
            }
        }
        .navigationTitle("Likes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LikeView(post: DeveloperPreview.MOCK_POSTS[0])
        }
    }
}
