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
    @FocusState private var isFocused: Bool

    var body: some View {
        
        ScrollView {
            GroupBox {
                VStack {
                    Image("github")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                        .frame(width: 100, height: 100)
                    
                    Text("GitHub Login")
                        .font(.system(size: 24).bold())
                    
                    Text("Enter your GitHub user name to proceed.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(4)
                    
                    TextField("myusername", text: $userLogin)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)
                        .background(.clear)
                        .focused($isFocused)
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
                                    isFocused = true
                                }
                            }
                        }
                        else {
                            shouldShowAlert = true
                            isFocused = true
                        }
                    } label: {
                        if userState.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        }
                        else {
                            Text("Confirm")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 12)
            }
            .alert(isPresented: $shouldShowAlert) {
                return Alert(title: Text("Login Error"), message: Text("Please enter a valid user login."))
            }
            .padding(16)
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    LoginView()
        .environment(UserState())
}
