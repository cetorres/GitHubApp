//
//  MainTabView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

enum Tab {
    case repos, followers, profile
}

struct MainTabView: View {
    @Environment(UserState.self) var userState
    @State private var selection = Tab.repos
    
    var body: some View {
        TabView(selection: $selection) {
            ReposListView()
                .tabItem {
                    Label("Repos", systemImage: "folder")
                }
                .tag(Tab.repos)
            UsersListView()
                .tabItem {
                    Label("Followers", systemImage: "person.2")
                }
                .tag(Tab.followers)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)
        }
        .environment(userState)
    }
}

#Preview {
    MainTabView()
        .environment(UserState())
}
