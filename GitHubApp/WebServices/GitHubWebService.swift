//
//  WebService.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/26/24.
//

import Foundation

final class GitHubWebService {
    static var shared = GitHubWebService()
    
    func getFollowers(userLogin: String) async throws -> [GitHubFollower] {
        return try await self.doGetRequest(endpoint: "https://api.github.com/users/\(userLogin)/followers")
    }
    
    func getUser(userLogin: String) async throws -> GitHubUser {
        return try await self.doGetRequest(endpoint: "https://api.github.com/users/\(userLogin)")
    }
    
    func getRepos(userLogin: String) async throws -> [GitHubRepo] {
        return try await self.doGetRequest(endpoint: "https://api.github.com/users/\(userLogin)/repos")
    }
    
    func getRepoContents(userLogin: String, repo: String) async throws -> [GitHubRepoContent] {
        return try await self.doGetRequest(endpoint: "https://api.github.com/repos/\(userLogin)/\(repo)/contents")
    }
    
    func getRepoReadme(userLogin: String, repo: String) async throws -> String {
        return try await self.doGetRequestForString(endpoint: "https://raw.githubusercontent.com/\(userLogin)/\(repo)/main/README.md")
    }

    private func doGetRequest<T:Codable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let response = response as? HTTPURLResponse {
            if response.statusCode == 404 {
                throw GitHubError.resourceNotFound
            }
            else if response.statusCode != 200 {
                throw GitHubError.invalidResponse
            }
        }
        else {
            throw GitHubError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw GitHubError.invalidData
        }
    }
    
    private func doGetRequestForString(endpoint: String) async throws -> String {
        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let response = response as? HTTPURLResponse {
            if response.statusCode == 404 {
                throw GitHubError.resourceNotFound
            }
            else if response.statusCode != 200 {
                throw GitHubError.invalidResponse
            }
        }
        else {
            throw GitHubError.invalidResponse
        }
        
        do {
            if let str = String(data: data, encoding: .utf8) {
                return str
            }
            else {
                throw GitHubError.invalidData
            }
        } catch {
            print(error.localizedDescription)
            throw GitHubError.invalidData
        }
    }
}
