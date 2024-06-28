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
                .alert("Log out", isPresented: $shouldShowAlert,
                    actions: {
                    Button("Yes", action: {
                        loginViewModel.logOut()
                    })
                    Button("No", role: .cancel, action: {})
                }, message: {
                    Text("Confirm logging out?")
                })
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(LoginViewModel())
}
