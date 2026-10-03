//
//  Endpoint.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
}

extension Endpoint {
    var method: String { "GET" }
    var queryItems: [URLQueryItem] { [] }
    var headers: [String: String] { [:] }

    func makeRequest() throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let url = components?.url else {
            throw HTTPError.invalidURL(rawUrl: path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}
