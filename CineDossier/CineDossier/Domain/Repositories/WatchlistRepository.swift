//
//  WatchlistRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 29/10/2026.
//

protocol WatchlistRepository {
    func items() async throws -> [Movie]
    func add(_ movie: Movie) async throws
    func remove(id: Int) async throws
    func contains(id: Int) async throws -> Bool
}
