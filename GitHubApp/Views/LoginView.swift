//
//  LoginView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(UserState.self) var userState
    @State private var userLogin: String = ""
    @State private var shouldShowAlert = false

    var body: some View {
        
        VStack {
            Text("GitHub Login")
                .font(.system(size: 24).bold())
            
            Text("Enter your GitHub login to proceed.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(4)
            
            TextField("", text: $userLogin)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .background(.clear)
                .padding()
            
            Button {
                if userLogin != "" {
                    Task {
                        let userExists = await userState.userExists(userLogin)
                        if userExists {
                            userState.setUserLogin(userLogin)
                        }
                        else {
                            shouldShowAlert = true
                        }
                    }
                }
                else {
                    shouldShowAlert = true
                }
            } label: {
                Text("Confirm")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 16)
        }
        .alert(isPresented: $shouldShowAlert) {
            return Alert(title: Text("Login Error"), message: Text("Please enter a valid user login."))
        }
    }
}

#Preview {
    LoginView()
        .environment(UserState())
}
