//
//  MainTabView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct MainTabView: View {
    @Environment(UserState.self) var userState
    
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
        .environment(userState)
    }
}

#Preview {
    MainTabView()
        .environment(UserState())
}
