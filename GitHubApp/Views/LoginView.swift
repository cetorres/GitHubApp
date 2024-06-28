//
//  LoginView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var userLogin: String = ""

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
                    loginViewModel.saveUserLogin(userLogin)
                }
            } label: {
                Text("Confirm")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    LoginView()
}
