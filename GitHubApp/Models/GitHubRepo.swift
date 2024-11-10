//
//  GitHubRepo.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/28/24.
//

import Foundation

struct GitHubRepo: Codable, Hashable {
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
    let createdAt: Date
    let updatedAt: Date
}

let testRepo = GitHubRepo(id: 1, name: "test-repo", fullName: "user/test-repo", description: "This is a test repo", url: "", htmlUrl: "", homepage: "", language: "JavaScript", defaultBranch: "main", stargazersCount: 0, watchersCount: 0, watchers: 3, forksCount: 0, createdAt: Date(), updatedAt: Date())

struct GitHubRepoContent: Codable {
    let name, path, sha: String
    let size: Int
    let url, htmlUrl: String
    let gitUrl: String
    let downloadUrl: String?
    let type: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case name, path, sha, size, url, htmlUrl, gitUrl, downloadUrl, type
        case links = "_links"
    }
}

struct Links: Codable {
    let linkSelf: String
    let git: String
    let html: String

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case git, html
    }
}
