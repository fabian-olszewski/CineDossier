//
//  TheMovieDatabaseService.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

import Foundation

struct TheMovieDatabaseAPIService {
    private let client: HTTPClient
    
    init(client: HTTPClient = DefaultHTTPClient()) {
        self.client = client
    }
    
    func fetchTrendingMovies() async throws -> [MovieDTO] {
        let trendingEndpoint = TheMovieDatabaseEndpoint.trending(type: .movies, timeWindow: .day)
        let response: TrendingResponseDTO = try await client.send(trendingEndpoint)
        return response.results
    }
    
    func fetchMovieGenres() async throws -> [GenreDTO] {
        let genresEndpoint = TheMovieDatabaseEndpoint.movieGenres
        let response: GenresResponseDTO = try await client.send(genresEndpoint)
        return response.genres
    }
}
