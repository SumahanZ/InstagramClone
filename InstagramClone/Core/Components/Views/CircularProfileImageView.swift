//
//  CircularProfileImageView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 05/09/23.
//

import SwiftUI
import Kingfisher

/*
 An enum made specially for the CircularProfileImageView to configure the image dimensions
 */
enum ProfileImageSize {
    case xXSmall, xSmall, small, medium, large
    /*
     Instead of always passing raw values, and we might forget what image should be what size, this enum will make it easier for us and we have a fixed number of options, instead of passing it manually.
     */
    var dimension: CGFloat {
        switch self {
        case .xXSmall:
            return 30
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 80
        }
    }
}

struct CircularProfileImageView: View {
    let user: User
    let size: ProfileImageSize

    var body: some View {
        if let imageURL = user.profileImageUrl {
            /*
             KingFisher has automatic image caching
             */
            KFImage(URL(string: imageURL))
                .resizable()
                .fade(duration: 0.25)
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: DeveloperPreview.MOCK_USERS[0], size: .large)
    }
}
