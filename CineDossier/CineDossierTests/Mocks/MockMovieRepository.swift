//
//  MockMovieRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

@testable import CineDossier

struct MockMovieRepository: MovieRepository {
    var searchResult: Result<[Movie], Error> = .success([])

    func fetchTrendingMovies() async throws -> [Movie] { [] }

    func fetchMovies(byQuery query: String) async throws -> [Movie] {
        try searchResult.get()
    }
}
