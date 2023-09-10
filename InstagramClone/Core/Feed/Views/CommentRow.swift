//
//  CommentRow.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import SwiftUI

struct CommentRow: View {
    let comment: Comment

    var body: some View {
        HStack(alignment: .center) {
            if let user = comment.user {
                CircularProfileImageView(user: user, size: .xSmall)
            }

            VStack(alignment: .leading, spacing: 3) {
                if let username = comment.user?.username {
                    Text(username)
                        .fontWeight(.semibold)
                }

                Text(comment.content)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.4, alignment: .leading)


                Text("6 Likes")
                    .padding(.leading, 1)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)

            }
            .font(.footnote)

            Spacer()

            Image(systemName: "heart.fill")
                .imageScale(.small)
                .foregroundColor(.red)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(comment: DeveloperPreview.MOCK_COMMENTS[0])
            .previewLayout(.sizeThatFits)
    }
}
