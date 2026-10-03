//
//  HTTPError.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

import Foundation

enum HTTPError: Error, LocalizedError {
    case invalidURL(rawUrl: String)
    case requestFailed(statusCode: Int)
    case decodingFailed(Error)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(statusCode: let code):
            return "Request failed with status code: \(code)"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response"
        }
    }
}
