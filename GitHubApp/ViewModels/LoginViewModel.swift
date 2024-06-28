//
//  LoginViewModel.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var userLogin: String = ""
    
    init() {
        if let savedUserLogin = UserDefaults.standard.string(forKey: "userLogin") {
            self.userLogin = savedUserLogin
        }
    }
    
    func saveUserLogin(_ userLogin: String) {
        self.userLogin = userLogin
        UserDefaults.standard.setValue(userLogin, forKey: "userLogin")
    }
    
    func logOut() {
        self.userLogin = ""
        UserDefaults.standard.setValue(self.userLogin, forKey: "userLogin")
    }
}
