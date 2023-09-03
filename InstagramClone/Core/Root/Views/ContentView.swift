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
    @StateObject private var loggedInVM = LoginViewModel()
    var body: some View {
        Group {
            if contentVM.userSession == nil {
                LoginView()
                    .environmentObject(registrationVM)
            } else {
                MainTabView()
                    .environmentObject(loggedInVM)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
