//
//  ReposListViewModel.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/28/24.
//

import Foundation

extension ReposListView {
    @Observable
    final class ViewModel {
        private(set) var repos: [GitHubRepo]?
        private(set) var isLoading = false
        var shouldShowErrorAlert = false
        private(set) var errorMessage: String?
        
        func getRepos(userLogin: String) async {
            self.isLoading = true
            do {
                let repos = try await GitHubWebService.shared.getRepos(userLogin: userLogin)
                self.repos = repos
                self.isLoading = false
            } catch (let error as GitHubError) {
                print(error.errorDescription)
                self.repos = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.errorDescription
                self.isLoading = false
            } catch {
                print(error.localizedDescription)
                self.repos = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
