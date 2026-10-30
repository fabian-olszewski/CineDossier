//
//  DetailsViewModel.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 30/10/2026.
//

import Foundation
import SwiftData

@Observable
class DetailsViewModel {
    let movie: Movie
    
    private let playbackRepository: PlaybackRepository
    private let watchlistRepository: WatchlistRepository
    
    private(set) var isLoadingPlayback = false
    private(set) var playbackItems: [PlaybackItem] = []
    private(set) var isInWatchlist = false
    
    var isPlayerPresented = false
    var errorMessage: String?
    
    init(movie: Movie,
         playbackRepository: PlaybackRepository = StaticPlaybackRepository(),
         watchlistRepository: WatchlistRepository = LocalWatchlistRepository()) {
        self.movie = movie
        self.playbackRepository = playbackRepository
        self.watchlistRepository = watchlistRepository
    }
    
    var title: String {
        movie.title
    }
    
    var averageVote: Double {
        movie.voteAverage
    }
    
    var description: String {
        movie.overview
    }
    
    var poster: URL? {
        movie.posterURL(size: .large)
    }
    
    func didTapPlay() async {
        guard !isLoadingPlayback else { return }
        isLoadingPlayback = true
        errorMessage = nil
        defer { isLoadingPlayback = false }

        do {
            let items = try await playbackRepository.items(for: movie)
            guard !items.isEmpty else {
                errorMessage = "No items to play"
                return
            }
            playbackItems = items
            isPlayerPresented = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loadWatchListState() async {
        isInWatchlist = (try? await watchlistRepository.contains(id: movie.id)) ?? false
    }
    
    func toggleWatchlist() async {
        do {
            if isInWatchlist {
                try await watchlistRepository.remove(id: movie.id)
                isInWatchlist = false
            } else {
                try await watchlistRepository.add(movie)
                isInWatchlist = true
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
