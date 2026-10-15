//
//  SearchViewModel.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 15/10/2026.
//

import Foundation

@Observable
class SearchViewModel {
    private let movieRepository: MovieRepository
    
    var searchText = ""
    var movies: [Movie] = []
    
    var isLoading = false
    var errorMessage: String?
    
    var debounceTime: Int
    
    var trimmedQuery: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(movieRepository: MovieRepository = RemoteMovieRepository(),
         debounceTimeInMilliseconds: Int = 400) {
        self.movieRepository = movieRepository
        self.debounceTime = debounceTimeInMilliseconds
    }
    
    func search() async {
        let query = trimmedQuery
        guard !query.isEmpty else {
            movies = []
            errorMessage = nil
            isLoading = false
            return
        }
        
        isLoading = true
        errorMessage = nil
        do {
            try await Task.sleep(for: .milliseconds(debounceTime))
            movies = try await movieRepository.fetchMovies(byQuery: query)
        } catch {
            if Task.isCancelled { return }
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
