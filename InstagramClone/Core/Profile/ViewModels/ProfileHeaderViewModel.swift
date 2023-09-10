//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 07/09/23.
//

import Foundation
import Firebase

class ProfileHeaderViewModel: ObservableObject {
    @Published var user: User
    @Published var postCount: Int?
    @Published var followers: [User] = []
    @Published var following: [User] = []
    
    var isFollower: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        if !user.isCurrentUser && user.followers.contains(currentUid) {
            return true
        } else {
            return false
        }
    }
    
    init(user: User) {
        self.user = user
        //        Task {
        //            try? await getNumberOfPostByUser()
        //        }
    }
    
    @MainActor
    func getNumberOfPostByUser() async throws {
        let posts = try await PostService.fetchUserPosts(user: user)
        self.postCount = posts.count
    }
    
    @MainActor
    func changeFollowersState() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let currentUser = try await UserService.fetchUser(uid: currentUid)
        var followers = user.followers
        var following = currentUser.following
        
        if isFollower {
            followers.removeAll(where: ({ $0 == currentUid }))
            following.removeAll(where: ({ $0 == user.id }))

        } else {
            followers.append(currentUid)
            following.append(user.id)
        }
        
        user = user.updateFields(id: nil, username: nil, email: nil, profileImageUrl: nil, fullName: nil, bio: nil, following: nil, followers: followers)
        let currentUserData = currentUser.updateFields(id: nil, username: nil, email: nil, profileImageUrl: nil, fullName: nil, bio: nil, following: following, followers: nil)
        guard let encodedDataTargetUser = try? Firestore.Encoder().encode(user), let encodedDataCurrentUser = try? Firestore.Encoder().encode(currentUserData) else { return }
        try await Firestore.firestore().collection("users").document(user.id).updateData(encodedDataTargetUser)
        try await Firestore.firestore().collection("users").document(currentUid).updateData(encodedDataCurrentUser)
    }

    @MainActor
    func fetchFollowersUser() async throws {
        followers = try await UserService.fetchFollowersUser(user: user)
    }

    @MainActor
    func fetchFollowingsUser() async throws {
        following = try await UserService.fetchFollowingUser(user: user)
    }
}
