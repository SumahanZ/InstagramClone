//
//  AddEmailView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

struct AddEmailView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            RegistrationField(title: "Add your email", subtitle: "You'll use this email to sign in your account", textFieldText: "Email", registrationFlow: .email)
                .navigationBarBackButtonHidden()

            NavigationLink {
                CreateUsernameView()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            .padding(.vertical)

            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss.callAsFunction()
                    }
            }
        }
    }
}

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddEmailView()
                .environmentObject(DeveloperPreview.registrationVMPreview)
        }
    }
}
