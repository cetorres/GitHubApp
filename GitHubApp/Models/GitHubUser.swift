//
//  GitHubUser.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/25/24.
//

import Foundation

struct GitHubFollower: Codable {
    let login: String
    let id: Int
    let avatarUrl: String?
    let url: String?
    let htmlUrl: String?
}

struct GitHubUser: Codable {
    let login: String
    let id: Int
    let avatarUrl: String?
    let url: String?
    let htmlUrl: String?
    let bio: String?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let twitterUsername: String?
    let followers: Int?
    let following: Int?
    let createdAt: Date
    let updatedAt: Date
}

let testFollower = GitHubFollower(login: "test", id: 1, avatarUrl: "", url: "", htmlUrl: "")
let testUser = GitHubUser(login: "test", id: 1, avatarUrl: "", url: "", htmlUrl: "", bio: "This is a test user.", name: "Test User", company: "Another Company", blog: "", location: "USA", email: "", twitterUsername: "", followers: 0, following: 0, createdAt: Date(), updatedAt: Date())
