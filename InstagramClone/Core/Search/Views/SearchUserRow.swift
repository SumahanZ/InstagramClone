//
//  SearchUserRow.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import SwiftUI

struct SearchUserRow: View {
    let user: User
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
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

struct SearchUserRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if let user = DeveloperPreview.MOCK_USERS.first {
                SearchUserRow(user: user)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
