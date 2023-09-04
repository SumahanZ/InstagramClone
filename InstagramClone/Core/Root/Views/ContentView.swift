//
//  ContentView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentVM = ContentViewModel()
    @StateObject private var registrationVM = RegistrationViewModel()
    
    var body: some View {
        Group {
            if contentVM.userSession == nil {
                LoginView()
                    .environmentObject(registrationVM)
            } else if let currentUser = contentVM.currentUser {
                MainTabView(user: currentUser)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
