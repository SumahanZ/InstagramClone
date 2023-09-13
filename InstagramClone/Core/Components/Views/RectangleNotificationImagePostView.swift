//
//  RectangleNotificationImagePostView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 11/09/23.
//

import SwiftUI
import Kingfisher

struct RectangleNotificationImagePostView: View {
    let post: Post
    let size: ProfileImageSize
    
    var body: some View {
        KFImage(URL(string: post.imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: size.dimension, height: size.dimension)
            .clipShape(Rectangle())
    }
}

struct RectangleNotificationImagePostView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleNotificationImagePostView(post: DeveloperPreview.MOCK_POSTS[0], size: .profile)
    }
}
