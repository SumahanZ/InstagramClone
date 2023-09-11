//
//  UploadPostViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
/*
 In summary, the purpose of having a service class in a ViewModel is to create a clear separation between Ul-related logic (ViewModel, changing the text of a textfield) and data-related operations (Service, fetching/updating data).
 */
/*
 Async function happens in the background thread, therefore when we have something to do with changing the ui, it has to happen in the main thread
 */
@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var postImage: Image?
    /*
     We don't make this published because we are not presenting this in the view, neither interacting this variable with the view
     */
    private var uiImage: UIImage?
    @Published var caption: String = ""
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(item: selectedImage) } }
    }

    private func loadImage(item: PhotosPickerItem?) async {
        guard let item, let data = try? await item.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) else { return }
        /*
         gets the image data from the photopicker
         */
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }

    /*
     We should not access binding variables that are used in textfield directly, instead we should pass it as a parameter
     */
    func uploadPost() async throws {
        guard let uid = Auth.auth().currentUser?.uid, let uiImage, !self.caption.isEmpty else { return }
        /*
         Points to a document of a collection, creates the collection if it doesn't exist
         Firebase automatically generates a document identifier (similar to UUID().uuidString) based on the collection("posts")
         */
        let postRef = Firestore.firestore().collection("posts").document()
        /*
         We have a property uiImage, and the guard let above will be useful in checking if the image is optional or not. If nil that means an image hasn't been picked or not yet in storage and this function won't execute any further
         */
        guard let imageURL = try await ImageUploader.saveImage(image: uiImage, pathName: "post_images") else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: self.caption, likes: 0, imageUrl: imageURL, timeStamp: Timestamp())
        guard let encodedData = try? Firestore.Encoder().encode(post) else { return }
        try await Firestore.firestore().collection("posts").document(post.id).setData(encodedData)
    }
}
