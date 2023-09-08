//
//  UserList.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 07/09/23.
//

import SwiftUI

struct UserList: View {
    let users: [User]

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    UserRow(user: user)
                }
            }
        }
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList(users: DeveloperPreview.MOCK_USERS)
    }
}
