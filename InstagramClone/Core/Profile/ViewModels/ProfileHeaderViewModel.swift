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
        Task {
            try? await getNumberOfPostByUser()
        }
    }
    
    @MainActor
    func getNumberOfPostByUser() async throws {
        let posts = try await PostService.fetchUserPosts(user: user)
        self.postCount = posts.count
    }
    
    @MainActor
    func changeFollowersState() async throws {
        var followers = user.followers
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        if isFollower {
            followers.removeAll(where: ({ $0 == currentUid }))
        } else {
            followers.append(currentUid)
        }
        
        self.user = self.user.updateFields(id: nil, username: nil, email: nil, profileImageUrl: nil, fullName: nil, bio: nil, following: nil, followers: followers)
        guard let encodedData = try? Firestore.Encoder().encode(self.user) else { return }
        try await Firestore.firestore().collection("users").document(self.user.id).updateData(encodedData)
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
