//
//  GitHubError.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/28/24.
//

import Foundation

enum GitHubError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String {
        switch self {
        case .invalidData: return "Invalid data received."
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "Invalid response received."
        }
    }
}
