//
//  UserStatView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

enum StatViewSelection {
    case followers, following, post
}

struct UserStatView: View {
    let user: User
    let value: Int
    let title: String
    let pageSelection: StatViewSelection

    var body: some View {
        VStack {
            NavigationLink {
                ProfileFollowView(user: user, selection: pageSelection)
            } label: {
                VStack {
                    Text(value.description)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(title)
                        .font(.footnote)
                }
                .frame(width: 76)
            }
        }
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(user: DeveloperPreview.MOCK_USERS[0], value: 3, title: "Followers", pageSelection: .followers)
    }
}
