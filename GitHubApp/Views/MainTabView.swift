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
    @State private var selectedTab = Tab.repos
    @State private var reposStack = NavigationPath()
    @State private var followersStack = NavigationPath()
    @State private var profileStack = NavigationPath()
    
    var body: some View {
        TabView(selection: tabSelection) {
            ReposListView(path: $reposStack)
                .tabItem {
                    Label("Repos", systemImage: "folder")
                }
                .tag(Tab.repos)

            UsersListView(path: $followersStack)
                .tabItem {
                    Label("Followers", systemImage: "person.2")
                }
                .tag(Tab.followers)

            ProfileView(path: $profileStack)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)

        }
        .environment(userState)
    }
    
    var tabSelection: Binding<Tab> {
        return .init {
            return selectedTab
        } set: { newValue in
            if newValue == selectedTab {
                switch newValue {
                case .repos: reposStack = NavigationPath()
                case .followers: followersStack = NavigationPath()
                case .profile: profileStack = NavigationPath()
                }
            }
            selectedTab = newValue
        }
    }
}

#Preview {
    MainTabView()
        .environment(UserState())
}
