//
//  GenreRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 11/08/2026.
//

protocol GenreRepository {
    func fetchGenres() async throws -> [Genre]
}
