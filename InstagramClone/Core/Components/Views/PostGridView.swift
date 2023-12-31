//
//  PostGridView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @StateObject private var profileVM: PostGridViewModel
    
    init(user: User) {
        _profileVM = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    private let gridColumns: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 1) {
                ForEach(profileVM.posts) { post in
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageDimension)
                        .clipped()
                }
            }
        }
        .refreshable {
            Task { try? await profileVM.fetchUserPosts() }
        }
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView(user: DeveloperPreview.MOCK_USERS[0])
    }
}
