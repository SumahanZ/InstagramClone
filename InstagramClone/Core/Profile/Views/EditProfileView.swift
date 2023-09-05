//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 04/09/23.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    let user: User
    @State private var imagePickerPresented = false
    @StateObject private var profileVM: EditProfileViewModel

    init(user: User) {
        self.user = user
        _profileVM = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                PhotosPicker(selection: $profileVM.selectedImage) {
                    VStack {
                        if let image = profileVM.profileImage {
                            image
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(.gray)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(.gray)
                                .clipShape(Circle())
                        }
                        
                        Text("Edit profile picture")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Divider()
                    }
                }
                .padding(.vertical, 8)

                VStack {
                    EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $profileVM.fullName)
                    EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $profileVM.bio)
                }

                Spacer()
            }
            .photosPicker(isPresented: $imagePickerPresented, selection: $profileVM.selectedImage)
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Text("Cancel")
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task { try? await profileVM.updateUserData() }
                    } label: {
                        Text("Done")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: DeveloperPreview.MOCK_USERS[0])
    }
}
