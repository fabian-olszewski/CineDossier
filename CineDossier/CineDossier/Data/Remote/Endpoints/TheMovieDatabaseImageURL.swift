//
//  TheMovieDatabaseImageURL.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import Foundation

enum TheMovieDatabasePosterSize: String {
    case small = "w185"
    case medium = "w342"
    case large = "w500"
    case original
}

extension Movie {
    func posterURL(size: TheMovieDatabasePosterSize = .medium) -> URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(posterPath)")
    }
}
