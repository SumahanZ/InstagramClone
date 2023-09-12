//
//  CommentRow.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import SwiftUI
import Firebase

struct CommentRowView: View {
    let comment: Comment
    @EnvironmentObject var commentVM: CommentViewModel
    
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
                
                if !comment.commentLikers.isEmpty {
                    Text("\(comment.commentLikers.count) Likes")
                        .padding(.leading, 1)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                
            }
            .font(.footnote)
            
            Spacer()
            
            Image(systemName: comment.commentLikers.contains(Auth.auth().currentUser?.uid ?? "") ? "heart.fill" : "heart")
                .imageScale(.small)
                .foregroundColor(comment.commentLikers.contains(Auth.auth().currentUser?.uid ?? "") ? .red : Color.black.opacity(0.4))
                .contentShape(Rectangle())
                .onTapGesture {
                    Task { try? await commentVM.commentChangeLikeState(comment: comment) }
                }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: DeveloperPreview.MOCK_COMMENTS[0])
            .previewLayout(.sizeThatFits)
    }
}
