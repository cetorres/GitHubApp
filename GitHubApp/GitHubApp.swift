//
//  GitHubApp.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/25/24.
//

import SwiftUI

@main
struct GitHubApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            if loginViewModel.userLogin != "" {
                MainTabView()
            }
            else {
                LoginView()
            }
        }
        .environmentObject(loginViewModel)
    }
}
