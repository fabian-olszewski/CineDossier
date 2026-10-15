//
//  SearchViewModelTests.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 15/10/2026.
//

import XCTest
@testable import CineDossier

struct MockMovieRepository: MovieRepository {
    var searchResult: Result<[Movie], Error> = .success([])

    func fetchTrendingMovies() async throws -> [Movie] { [] }

    func fetchMovies(byQuery query: String) async throws -> [Movie] {
        try searchResult.get()
    }
}

private struct TestError: LocalizedError {
    var errorDescription: String? { "Test error description" }
}

@MainActor
final class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    
    func testSearchWithQueryLoadsMovies() async {
        sut = SearchViewModel(movieRepository: MockMovieRepository(searchResult:
                .success(Array(Movie.samples.prefix(3)))
        ), debounceTimeInMilliseconds: 0)
        sut.searchText = "The"
        
        await sut.search()
        
        XCTAssertEqual(sut.movies.count, 3)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    func testEmptyQueryClearsState() async {
        sut = SearchViewModel(movieRepository: MockMovieRepository(searchResult:
                .success(Array(Movie.samples.prefix(3)))
        ), debounceTimeInMilliseconds: 0)
        sut.searchText = "The"
        await sut.search()
        
        sut.searchText = " "
        await sut.search()
        
        XCTAssertTrue(sut.movies.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testRepositoryErrorSetsErrorMessage() async {
        sut = SearchViewModel(movieRepository: MockMovieRepository(searchResult:
                .failure(TestError())
        ), debounceTimeInMilliseconds: 0)
        sut.searchText = "Doesn't matter"
        
        await sut.search()
        
        XCTAssertEqual(sut.errorMessage, TestError().errorDescription)
        XCTAssertFalse(sut.isLoading)
    }
}
