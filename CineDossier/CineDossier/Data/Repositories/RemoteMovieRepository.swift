//
//  RemoteMovieRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 11/08/2026.
//

struct RemoteMovieRepository: MovieRepository {
    private let apiService: TheMovieDatabaseAPIService
    
    init(apiService: TheMovieDatabaseAPIService = TheMovieDatabaseAPIService()) {
        self.apiService = apiService
    }
    
    func fetchTrendingMovies() async throws -> [Movie] {
        try await apiService.fetchTrendingMovies()
            .map { $0.toDomain() }
    }
}
