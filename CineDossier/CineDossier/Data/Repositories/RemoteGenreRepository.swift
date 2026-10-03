//
//  RemoteGenreRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 11/08/2026.
//

struct RemoteGenreRepository: GenreRepository {
    private let apiService: TheMovieDatabaseAPIService
    
    init(apiService: TheMovieDatabaseAPIService = TheMovieDatabaseAPIService()) {
        self.apiService = apiService
    }
    
    func fetchGenres() async throws -> [Genre] {
        try await apiService.fetchMovieGenres()
            .map { $0.toDomain() }
    }
}
