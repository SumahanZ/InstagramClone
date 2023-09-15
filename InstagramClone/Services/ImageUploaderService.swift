//
//  ImageUploaderService.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 05/09/23.
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI
/*
 This is going to be a helper that is going to allow us to upload images from anywhere in our application
 The reason we put it in the global services folder is because it is going to be used in multiple places (generic)
 */
//for some reason we can't upload SwiftUI Images into FireStorage, we can only use UIImage
struct ImageUploader {

    static func saveImage(image: UIImage, pathName: String) async throws -> String? {
        /*
         We need to compress the image data is because sometimes we have images that are like 4k resolution and big zie, therefore we need to compress it because we don't want to put the whole 4k resolution into the storage
         Each images (profile images/ post images) will have their own compressionquality
         */
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let imageName = UUID().uuidString
        /*
         create a filepath of where we want to save the images at (similar to FileManager)
         */
        let ref = Storage.storage().reference(withPath: "/\(pathName)/\(imageName)")

        do {
            /*
             Put the image that has been converted into data into the StorageReference
             */
            let _ = try await ref.putDataAsync(imageData)
            let getImageURL = try await ref.downloadURL()
            /*
             Get the imageURL that has been converted to string so that it can act as a pointer to that image, because we cannot store an image in FirebaseFirestore
             */
            return getImageURL.absoluteString
        } catch let error {
            print("Failed to upload image with error: \(error.localizedDescription)")
            return nil
        }
    }
}
