//
//  UserViewModel.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import Foundation

extension UserView {
    @Observable
    final class ViewModel {
        private(set) var user: GitHubUser?
        private(set) var isLoading = false
        var shouldShowErrorAlert = false
        private(set) var errorMessage: String?
        
        func getUser(userLogin: String) async {
            self.isLoading = true
            do {
                let user = try await GitHubWebService.getUser(userLogin: userLogin)
                self.user = user
            } catch (let error as GitHubError) {
                print(error.errorDescription)
                self.user = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.errorDescription
                self.isLoading = false
            } catch {
                print(error.localizedDescription)
                self.user = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
