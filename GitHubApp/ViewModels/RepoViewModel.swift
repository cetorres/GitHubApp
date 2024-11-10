//
//  RepoViewModel.swift
//  GitHubApp
//
//  Created by Carlos Eugenio Torres on 8/17/24.
//

import Foundation

extension RepoView {
    @Observable
    final class ViewModel {
        private(set) var repoContents: [GitHubRepoContent]?
        private(set) var repoReadme: String?
        private(set) var isLoading = false
        var shouldShowErrorAlert = false
        private(set) var errorMessage: String?
        
        func getRepoContentAndReadme(userLogin: String, repo: String) async {
            self.isLoading = true
            do {
                let repoContents = try await GitHubWebService.shared.getRepoContents(userLogin: userLogin, repo: repo)
                self.repoContents = repoContents
                let repoReadme = try await GitHubWebService.shared.getRepoReadme(userLogin: userLogin, repo: repo)
                self.repoReadme = repoReadme
                self.isLoading = false
            } catch (let error as GitHubError) {
                print(error.errorDescription)
                self.repoContents = nil
                self.repoReadme = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.errorDescription
                self.isLoading = false
            } catch {
                print(error.localizedDescription)
                self.repoContents = nil
                self.repoReadme = nil
                self.shouldShowErrorAlert = true
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
