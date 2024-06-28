//
//  MainUserView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var shouldShowAlert = false
    
    var body: some View {
        NavigationStack {
            UserView(userLogin: loginViewModel.userLogin)
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
                                loginViewModel.logOut()
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
        .environmentObject(LoginViewModel())
}
