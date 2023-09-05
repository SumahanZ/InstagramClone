//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    let post: Post
    
    var body: some View {
        VStack {
            //image + username
            HStack {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .xSmall)

                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding(.leading)

            //post image
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())

            //action button
            HStack(spacing: 16) {
                Button {
                    print("Like Post")
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }

                Button {
                    print("Comment on Post")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }

                Button {
                    print("Share Post")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }

                Spacer()

            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)

            //likes label
            Text("\(post.likes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)

            //caption label
            //"+" will make the text line up together
            HStack {
                Text("\(post.user?.username ?? "") ")
                    .fontWeight(.semibold) +
                Text(post.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 10)
            .padding(.top, 1)

            //timestamp label
            Text("6h ago")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundColor(.gray)

        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(post: DeveloperPreview.MOCK_POSTS[1])
    }
}
