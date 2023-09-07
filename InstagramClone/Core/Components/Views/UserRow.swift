//
//  SearchUserRow.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import SwiftUI

struct UserRow: View {
    let user: User
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                if let fullName = user.fullName {
                    Text(fullName)
                }
            }
            .font(.footnote)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if let user = DeveloperPreview.MOCK_USERS.first {
                UserRow(user: user)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
