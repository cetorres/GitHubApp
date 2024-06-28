//
//  WebService.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/26/24.
//

import Foundation

final class GitHubWebService {
    static func getFollowers(userLogin: String) async throws -> [GitHubFollower] {
        let endpoint = "https://api.github.com/users/\(userLogin)/followers"
        
        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GitHubError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([GitHubFollower].self, from: data)
        } catch {
            print(error.localizedDescription)
            throw GitHubError.invalidData
        }
    }
    
    static func getUser(userLogin: String) async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/\(userLogin)"
        
        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GitHubError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw GitHubError.invalidData
        }
    }
    
    static func getRepos(userLogin: String) async throws -> [GitHubRepo] {
        let endpoint = "https://api.github.com/users/\(userLogin)/repos"
        
        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GitHubError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([GitHubRepo].self, from: data)
        } catch {
            print(error.localizedDescription)
            throw GitHubError.invalidData
        }
    }
}
