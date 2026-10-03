//
//  Movie.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

extension MovieDTO {
    func toDomain() -> Movie {
        Movie(id: id, title: title, overview: overview, posterPath: posterPath, voteAverage: voteAverage)
    }
}
