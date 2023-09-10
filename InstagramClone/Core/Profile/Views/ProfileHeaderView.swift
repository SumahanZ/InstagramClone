//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 01/09/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var showEditProfile = false
    @StateObject private var profileHeaderVM: ProfileHeaderViewModel
    
    init(user: User) {
        print(user)
        _profileHeaderVM = StateObject(wrappedValue: ProfileHeaderViewModel(user: user))
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                CircularProfileImageView(user: profileHeaderVM.user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8) {
                    UserStatView(followVM: profileHeaderVM, value: profileHeaderVM.postCount ?? 0, title: "Posts", pageSelection: .post)
                    UserStatView(followVM: profileHeaderVM, value: profileHeaderVM.user.followers.count, title: "Followers", pageSelection: .followers)
                    UserStatView(followVM: profileHeaderVM, value: profileHeaderVM.user.following.count, title: "Following", pageSelection: .following)
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                if let fullName = profileHeaderVM.user.fullName {
                    Text(fullName)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = profileHeaderVM.user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Button {
                if profileHeaderVM.user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    Task { try? await profileHeaderVM.changeFollowersState() }
                }
            } label: {
                Text(profileHeaderVM.user.isCurrentUser ? "Edit Profile" : profileHeaderVM.isFollower ? "Unfollow" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(profileHeaderVM.user.isCurrentUser ? .black : .white)
                    .frame(width: 360, height: 32)
                    .background(profileHeaderVM.user.isCurrentUser ? .white : Color(.systemBlue))
                    .cornerRadius(6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(profileHeaderVM.user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    }
            }
            
            Divider()
        }
        //temporary solution
        .onAppear {
            Task {
                profileHeaderVM.user = try! await UserService.fetchUser(uid: profileHeaderVM.user.id)
                try? await profileHeaderVM.getNumberOfPostByUser()
            }
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: profileHeaderVM.user)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: DeveloperPreview.MOCK_USERS[0])
            .previewLayout(.sizeThatFits)
    }
}
