//
//  UsersListViewModel.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/26/24.
//

import Foundation

extension UsersListView {
    @Observable
    final class ViewModel {
        private(set) var followers: [GitHubFollower]?
        private(set) var isLoading = false
        var shouldShowErrorAlert = false
        private(set) var errorMessage: String?
        
        func getFollowers(userLogin: String) async {
            self.isLoading = true
            do {
                let followers = try await GitHubWebService.getFollowers(userLogin: userLogin)
                self.followers = followers
                self.isLoading = false
            } catch (let error as GitHubError) {
                print(error.errorDescription)
                self.followers = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.errorDescription
                self.isLoading = false
            } catch {
                print(error.localizedDescription)
                self.followers = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
