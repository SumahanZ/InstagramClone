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
    @ObservedObject var followVM: ProfileHeaderViewModel

    var body: some View {
        Group {
            switch selection {
            case .followers:
                UserList(users: followVM.followers)
                    .onAppear {
                        Task { try? await followVM.fetchFollowersUser() }
                    }
                    .refreshable {
                        Task { try? await followVM.fetchFollowersUser() }
                    }
                    .padding(.top, 10)
                    .navigationTitle("Followers")
            case .following:
                UserList(users: followVM.following)
                    .onAppear {
                        Task { try? await followVM.fetchFollowingsUser() }
                    }
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
        ProfileFollowView(selection: .followers, followVM: ProfileHeaderViewModel(user: DeveloperPreview.MOCK_USERS[0]))
    }
}

