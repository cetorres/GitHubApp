//
//  MainUserView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserState.self) var userState
    @State private var shouldShowAlert = false
    
    var body: some View {
        NavigationStack {
            UserView(userLogin: userState.userLogin)
                .toolbar {
                    Button("Log out") {
                        shouldShowAlert = true
                    }
                }
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
    ProfileView()
        .environment(UserState())
}
