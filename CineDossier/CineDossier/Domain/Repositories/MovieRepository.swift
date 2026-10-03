//
//  MovieRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 11/08/2026.
//

protocol MovieRepository {
    func fetchTrendingMovies() async throws -> [Movie]
}
