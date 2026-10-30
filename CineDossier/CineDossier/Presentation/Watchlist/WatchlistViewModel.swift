//
//  WatchlistViewModel.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 30/10/2026.
//

import Foundation

@Observable
class WatchlistViewModel {
    private let watchlistRepository: WatchlistRepository
    
    var movies: [Movie] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(watchlistRepository: WatchlistRepository = LocalWatchlistRepository()) {
        self.watchlistRepository = watchlistRepository
    }
    
    func loadWatchlistItems() async {
        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }
        do {
            movies = try await watchlistRepository.items()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
