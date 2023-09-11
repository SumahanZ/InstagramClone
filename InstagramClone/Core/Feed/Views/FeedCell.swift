//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @Binding var selectedPost: Post?
    @State private var detents: PresentationDetent = .medium
    @EnvironmentObject var feedVM: FeedViewModel
    let post: Post
    let userID: String
    
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
                    Task { try? await feedVM.updateLikes(post: post) }
                } label: {
                    Image(systemName: post.postLikers.contains(userID) ? "heart.fill" : "heart")
                        .foregroundColor(post.postLikers.contains(userID) ? .red : .black)
                        .imageScale(.large)
                }
                
                Button {
                    selectedPost = post
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
            NavigationLink {
                LikeView(post: post)
            } label: {
                Text("\(post.likes) likes")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 1)
            }
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
        .sheet(item: $selectedPost) { value in
            CommentSheetView(post: value)
                .presentationDetents([.medium])
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(selectedPost: .constant(nil), post: DeveloperPreview.MOCK_POSTS[1], userID: DeveloperPreview.MOCK_USERS[0].id)
    }
}
