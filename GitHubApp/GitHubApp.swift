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
            }
            else {
                LoginView()
            }
        }
        .environment(userState)
    }
}
