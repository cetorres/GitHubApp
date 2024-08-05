//
//  GitHubApp.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/25/24.
//

import SwiftUI

@main
struct GitHubApp: App {
    @State var userState = UserState()
    
    var body: some Scene {
        WindowGroup {
            if userState.isUserLoggedIn {
                MainTabView()
                    .preferredColorScheme(userState.appearance == "dark" ? .dark : userState.appearance == "light" ? .light : nil)
            }
            else {
                LoginView()
                    .preferredColorScheme(userState.appearance == "dark" ? .dark : userState.appearance == "light" ? .light : nil)
            }
        }
        .environment(userState)
    }
}
