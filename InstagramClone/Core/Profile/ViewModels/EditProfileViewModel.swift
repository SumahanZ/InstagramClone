//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 04/09/23.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var fullName: String = ""
    @Published var bio: String = ""
    @Published var profileImage: Image?
    private var uiImage: UIImage?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task { await loadImage(item: selectedImage) }
        }
    }
    
    init(user: User) {
        self.user = user
        self.fullName = user.fullName ?? ""
        self.bio = user.bio ?? ""
    }

    /*
     We can't directly use the self.selectedImage, we have to pass it in through the parameter
     */
    private func loadImage(item: PhotosPickerItem?) async {
        guard let item, let data = try? await item.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    /*
     We need the user object so we can compare the textfield value with the current user fields value
     We can make a let data = [String:Any]() and then fill in the fields like data["fullName"] = "Hello to firebase but and send the updatedData right away or use encoder.
     I prefer using the encoder
     */
    func updateUserData() async throws {
        //update profile image if changed
        if let uiImage {
            /*
             ImageUploader.saveImage() returns downloadURL, so we can reference the image that has already been saved inside of the FirebaseStorage
             */
            let imageURL = try await ImageUploader.saveImage(image: uiImage, pathName: "profile_images")
            self.user = user.updateFields(id: nil, username: nil, email: nil, profileImageUrl: imageURL, fullName: nil, bio: nil)
        }
        //update name if changed
        if !fullName.isEmpty && user.fullName != fullName {
            self.user = user.updateFields(id: nil, username: nil, email: nil, profileImageUrl: nil, fullName: fullName, bio: nil)
        }
        
        //update bio if changed
        if !bio.isEmpty && user.bio != bio {
            self.user = user.updateFields(id: nil, username: nil, email: nil, profileImageUrl: nil, fullName: nil, bio: bio)
        }

        //when using guard or if let try must be handle in a do catch block or use ?
        guard let encodedData = try? Firestore.Encoder().encode(user), !encodedData.isEmpty else { return }
        try await Firestore.firestore().collection("users").document(user.id).updateData(encodedData)
        
    }
}
