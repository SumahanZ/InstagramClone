//
//  ContentView.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 31/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    @StateObject private var registrationVM = RegistrationViewModel()
    var body: some View {
        Group {
            if vm.userSession == nil {
                LoginView()
                    .environmentObject(registrationVM)
            } else {
                MainTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
