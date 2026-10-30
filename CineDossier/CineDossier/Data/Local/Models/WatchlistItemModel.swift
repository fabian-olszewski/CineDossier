//
//  WatchlistItemModel.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 29/10/2026.
//

import SwiftData
import Foundation

@Model
final class WatchlistItemModel {
    @Attribute(.unique) var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var voteAverage: Double
    var addedAt: Date
    
    init(id: Int, title: String, overview: String, posterPath: String? = nil, voteAverage: Double, addedAt: Date = .now) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.addedAt = addedAt
    }
    
    convenience init(movie: Movie, addedAt: Date = .now) {
        self.init(id: movie.id,
                  title: movie.title,
                  overview: movie.overview,
                  posterPath: movie.posterPath,
                  voteAverage: movie.voteAverage,
                  addedAt: addedAt)
    }
}

extension WatchlistItemModel {
    func toDomain() -> Movie {
        Movie(id: id, title: title, overview: overview, posterPath: posterPath, voteAverage: voteAverage)
    }
}
