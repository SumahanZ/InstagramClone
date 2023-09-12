//
//  CommentSheetView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 09/09/23.
//

import SwiftUI

struct CommentSheetView: View {
    @StateObject private var commentVM: CommentViewModel
    let post: Post
    
    init(post: Post) {
        self.post = post
        _commentVM = StateObject(wrappedValue: CommentViewModel(post: post))
    }
    
    var body: some View {
        VStack {
            Text("Comments")
                .font(.headline)
                .fontWeight(.semibold)
            
            Divider()

            if !commentVM.comments.isEmpty {
                ScrollView {
                    LazyVStack {
                        ForEach(commentVM.comments) { comment in
                            CommentRowView(comment: comment)
                                .environmentObject(commentVM)
                        }
                    }
                }

            } else {
                Spacer()
                VStack(spacing: 10) {
                    Text("No comments yet")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Start the conversation.")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .fontWeight(.regular)
                }
            }

            Spacer()

            if let username = post.user?.username {
                GeometryReader { reader in
                    VStack(alignment: .leading) {
                        TextField("Add a comment for \(username)", text: $commentVM.commentContent)
                            .font(.subheadline)
                            .padding(.vertical, 10)
                            .frame(width: reader.size.width * 0.75)
                        
                    }
                    .padding(.horizontal, 15)
                    .frame(width: reader.size.width, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
                    .overlay(
                        Text("Post")
                            .opacity(commentVM.commentContent.isEmpty ? 0 : 1)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                            .disabled(commentVM.commentContent.isEmpty ? true : false)
                            .onTapGesture {
                                //TODO: Create comment for this post
                                Task {
                                    try? await commentVM.addComment(content: commentVM.commentContent)
                                    UIApplication.shared.endEditing()
                                }
                            }
                            .animation(.easeIn, value: commentVM.commentContent), alignment: .trailing
                    )
                }
                .frame(height: UIScreen.main.bounds.height * 0.05)
                .padding(.horizontal, 20)
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.vertical, 30)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onAppear {
            Task { try? await commentVM.fetchCommentsPost() }
        }
        .refreshable {
            Task { try? await commentVM.fetchCommentsPost() }
        }
    }
}

struct CommentSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CommentSheetView(post: DeveloperPreview.MOCK_POSTS[0])
    }
}
