//
//  MainTabView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        TabView {
            ReposListView()
                .tabItem {
                    Label("Repos", systemImage: "folder")
                }
            UsersListView()
                .tabItem {
                    Label("Followers", systemImage: "person.2")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .environmentObject(loginViewModel)
    }
}

#Preview {
    MainTabView()
        .environmentObject(LoginViewModel())
}
