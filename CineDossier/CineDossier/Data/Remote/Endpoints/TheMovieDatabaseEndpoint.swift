//
//  TheMovieDatabaseEndpoint.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

import Foundation

enum TheMovieDatabaseEndpoint: Endpoint {
    case trending(type: TrendingType, timeWindow: TrendingTimeWindow)
    case movieGenres
    
    enum TrendingType: String {
        case movies = "movie"
        case series = "tv"
        case people = "person"
        case all = "all"
    }
    
    enum TrendingTimeWindow: String {
        case day
        case week
    }
    
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3")! }
    
    var path: String {
        switch self {
            case .trending(let type, let timeWindow):
                return "/trending/\(type.rawValue)/\(timeWindow.rawValue)"
            case .movieGenres:
                return "/genre/movie/list"
        }
    }
    
    var headers: [String: String] {
        ["Authorization": "Bearer \(Secrets.tmdbReadAccessToken)"]
    }
}
