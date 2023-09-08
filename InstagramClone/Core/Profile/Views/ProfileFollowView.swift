//
//  ProfileFollowersView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 07/09/23.
//

import SwiftUI
import Foundation

struct ProfileFollowView: View {
    let selection: StatViewSelection
    @StateObject var followVM: ProfileFollowViewModel

    init(user: User, selection: StatViewSelection) {
        self.selection = selection
        _followVM = StateObject(wrappedValue: ProfileFollowViewModel(user: user))
    }

    var body: some View {
        Group {
            switch selection {
            case .followers:
                UserList(users: followVM.followers)
                    .refreshable {
                        Task { try? await followVM.fetchFollowersUser() }
                    }
                    .padding(.top, 10)
                    .navigationTitle("Followers")
            case .following:
                UserList(users: followVM.following)
                    .refreshable {
                        Task { try? await followVM.fetchFollowingsUser() }
                    }
                    .padding(.top, 10)
                    .navigationTitle("Followers")
            default:
                EmptyView()
            }
        }
    }
}

struct ProfileFollowView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFollowView(user: DeveloperPreview.MOCK_USERS[0], selection: .followers)
    }
}

