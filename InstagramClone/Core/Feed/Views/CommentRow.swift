//
//  CommentRow.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import SwiftUI

struct CommentRow: View {
    let comment: Comment
    let userID: String

    var body: some View {
        HStack {
            if let user = comment.user {
                CircularProfileImageView(user: user, size: .xSmall)
            }

            VStack(alignment: .leading) {
                if let username = comment.user?.username {
                    Text(username)
                        .fontWeight(.semibold)
                }


                Text(comment.content)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.4, alignment: .leading)

            }
            .font(.footnote)

            Spacer()

            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(comment: DeveloperPreview.MOCK_COMMENTS[0], userID: DeveloperPreview.MOCK_USERS[0].id)
            .previewLayout(.sizeThatFits)
    }
}
