//
//  GitHubRepo.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/28/24.
//

import Foundation

struct GitHubRepo: Codable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let url: String?
    let htmlUrl: String?
    let homepage: String?
    let language: String?
    let defaultBranch: String?
    let stargazersCount: Int
    let watchersCount: Int
    let watchers: Int
    let forksCount: Int
    let createdAt: String?
    let updatedAt: String?
}

let testRepo = GitHubRepo(id: 1, name: "test-repo", fullName: "user/test-repo", description: "This is a test repo", url: "", htmlUrl: "", homepage: "", language: "JavaScript", defaultBranch: "main", stargazersCount: 0, watchersCount: 0, watchers: 3, forksCount: 0, createdAt: "", updatedAt: "")
