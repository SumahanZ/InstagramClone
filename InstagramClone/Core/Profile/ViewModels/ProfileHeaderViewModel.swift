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
}
