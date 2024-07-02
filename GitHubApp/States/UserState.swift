//
//  UserState.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 7/2/24.
//

import Foundation
import Observation

@Observable
final class UserState {
    private(set) var userLogin: String = ""
    var isUserLoggedIn: Bool {
        return userLogin != ""
    }
    
    init() {
        if let savedUserLogin = UserDefaults.standard.string(forKey: "userLogin") {
            self.userLogin = savedUserLogin
        }
    }
    
    func setUserLogin(_ userLogin: String) {
        self.userLogin = userLogin
        UserDefaults.standard.setValue(userLogin, forKey: "userLogin")
    }
    
    func logOut() {
        self.userLogin = ""
        UserDefaults.standard.setValue(self.userLogin, forKey: "userLogin")
    }
    
    func userExists(_ userLogin: String) async -> Bool {
        do {
            let _ = try await GitHubWebService.shared.getUser(userLogin: userLogin)
            return true
        }
        catch (let error as GitHubError) {
            print(error.errorDescription)
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
