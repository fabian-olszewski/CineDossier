//
//  PlaybackRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

protocol PlaybackRepository {
    func items(for movie: Movie) async throws -> [PlaybackItem]
}
