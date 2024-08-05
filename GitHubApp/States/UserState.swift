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
    var appearance: String = "" {
        didSet {
            UserDefaults.standard.setValue(appearance, forKey: "appearance")
        }
    }
    var isLoading = false
    var isUserLoggedIn: Bool {
        return userLogin != ""
    }
    
    init() {
        if let savedUserLogin = UserDefaults.standard.string(forKey: "userLogin") {
            self.userLogin = savedUserLogin
        }
        if let savedAppearance = UserDefaults.standard.string(forKey: "appearance") {
            self.appearance = savedAppearance
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
        isLoading = true
        do {
            let _ = try await GitHubWebService.shared.getUser(userLogin: userLogin)
            isLoading = false
            return true
        }
        catch (let error as GitHubError) {
            print(error.errorDescription)
            isLoading = false
            return false
        } catch {
            print(error.localizedDescription)
            isLoading = false
            return false
        }
    }
}
