//
//  UploadPostViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import Foundation
import PhotosUI
import SwiftUI

/*
Async function happens in the background thread, therefore when we have something to do with changing the ui, it has to happen in the main thread
 */
@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var postImage: Image?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(item: selectedImage)
            }
        }
    }

    private func loadImage(item: PhotosPickerItem?) async {
        guard let item, let image = try? await item.loadTransferable(type: Image.self) else { return }
        /*
         gets the image data from the photopicker
         */
        postImage = image
    }
}
