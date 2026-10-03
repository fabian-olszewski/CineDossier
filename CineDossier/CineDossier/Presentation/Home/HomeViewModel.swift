//
//  HomeViewModel.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import Foundation

@Observable
class HomeViewModel {
    private let movieRepository: MovieRepository
    private let genreRepository: GenreRepository
    
    var genres: [Genre] = [] //Genre.samples
    var movies: [Movie] = [] //Movie.samples
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(movieRepository: MovieRepository = RemoteMovieRepository(),
         genreRepository: GenreRepository = RemoteGenreRepository()) {
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
    }
    
    func loadContent() async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            async let fetchedMovies = movieRepository.fetchTrendingMovies()
            async let fetchedGenres = genreRepository.fetchGenres()
            movies = try await fetchedMovies
            genres = try await fetchedGenres
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
