//
//  CommentSheetView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import SwiftUI

struct CommentSheetView: View {
    let post: Post
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(DeveloperPreview.MOCK_COMMENTS) { comment in
                    Text(comment.content)
                }
            }
        }
    }
}

struct CommentSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CommentSheetView(post: DeveloperPreview.MOCK_POSTS[0])
    }
}
