//
//  RegistrationField.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

enum RegistrationFlow {
    case email, username, password
}

struct RegistrationField: View {
    @EnvironmentObject var vm: RegistrationViewModel
    let title: String
    let subtitle: String
    let textFieldText: String
    let registrationFlow: RegistrationFlow
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(subtitle)
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            switch registrationFlow {
            case .password:
                SecureField(textFieldText, text: $vm.password)
                    .modifier(IGTextFieldModifier())
                    .padding(.top)
            case .email:
                TextField(textFieldText, text: $vm.email)
                    .textInputAutocapitalization(.none)
                    .modifier(IGTextFieldModifier())
                    .padding(.top)
            case .username:
                TextField(textFieldText, text: $vm.username)
                    .textInputAutocapitalization(.none)
                    .modifier(IGTextFieldModifier())
                    .padding(.top)
            }
        }
    }

    struct RegistrationField_Previews: PreviewProvider {
        static var previews: some View {
            RegistrationField(title: "Add your email", subtitle: "You'll use this email to sign in to your account", textFieldText: "Email", registrationFlow: .password)
                .environmentObject(RegistrationViewModel())
        }
    }
}
