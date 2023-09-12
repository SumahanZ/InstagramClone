//
//  FollowButton.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 11/09/23.
//

import SwiftUI

struct FollowButton: View {
    var body: some View {
        Text("Following")
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(6)
            .padding(.vertical, 7)
            .padding(.horizontal, 15)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray)
            }
    }
}

struct FollowButton_Previews: PreviewProvider {
    static var previews: some View {
        FollowButton()
    }
}
