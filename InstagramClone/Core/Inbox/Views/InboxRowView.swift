//
//  InboxRowView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 13/09/23.
//

import Foundation
import SwiftUI

struct InboxRowView: View {
    let user: User
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Eddie Brock")
                    .fontWeight(.semibold)
                
                if let fullName = user.fullName {
                    Text("Hey thanks man I appreciate that")
                        .lineLimit(2)
                        .font(.subheadline)
                }
            }
            .font(.subheadline)
            
            Spacer()
        }
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView(user: DeveloperPreview.MOCK_USERS[2])
    }
}
