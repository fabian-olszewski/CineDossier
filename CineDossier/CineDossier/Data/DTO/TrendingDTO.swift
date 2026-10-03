//
//  Trending.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

struct TrendingResponseDTO: Decodable {
    let results: [MovieDTO]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
