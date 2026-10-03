//
//  Movie.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 04/09/2026.
//

struct Movie: Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
}
