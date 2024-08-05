//
//  MainUserView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserState.self) var userState
    @Binding var path: NavigationPath
    @State private var shouldShowAlert = false
    
    var body: some View {
        NavigationStack(path: $path) {
            UserView(userLogin: userState.userLogin)
                .toolbar {
                    Button("Log out") {
                        shouldShowAlert = true
                    }
                }
                .environment(userState)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .actionSheet(isPresented: $shouldShowAlert) {
                    ActionSheet(
                        title: Text("Confirm logging out?"),
                        buttons: [
                            .destructive(Text("Yes")) {
                                userState.logOut()
                            },
                            .cancel(Text("No"))
                        ]
                    )
                }
        }
    }
}

#Preview {
    ProfileView(path: .constant(NavigationPath()))
        .environment(UserState())
}
