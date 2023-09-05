//
//  UploadPostView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var imagePickerPresented = false
    @Binding var selectedTab: Int
    @StateObject var uploadPostVM = UploadPostViewModel()
    
    var body: some View {
        VStack {
            //action tool bar
            HStack {
                Button {
                    resetUploadPost()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try? await uploadPostVM.uploadPost()
                        resetUploadPost()
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
                
            }
            .padding(.horizontal)
            //post image and caption
            HStack(spacing: 8) {
                if let postImage = uploadPostVM.postImage {
                    postImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .onTapGesture {
                            imagePickerPresented.toggle()
                        }
                }
                /*
                 New addition to textfield so when the field runs out of room it won't span to the right with the new text and the old text being hidden
                 But now it goes to a new line
                 */
                TextField("Enter your caption", text: $uploadPostVM.caption, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $uploadPostVM.selectedImage)
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(selectedTab: .constant(0))
    }
}

extension UploadPostView {
    private func resetUploadPost() {
        uploadPostVM.caption = ""
        uploadPostVM.postImage = nil
        uploadPostVM.selectedImage = nil
        selectedTab = 0
    }
}
