//
//  MoviePosterURLTests.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 22/09/2026.
//

import XCTest
@testable import CineDossier

final class MoviePosterURLTests: XCTestCase {
    func testPosterURLUsesMediumSizeByDefault() {
        let movie = Movie(id: 1,
                          title: "Title",
                          overview: "Overview",
                          posterPath: "/abc123.jpg",
                          voteAverage: 8.0)
        let expectedPosterURL = "https://image.tmdb.org/t/p/w342/abc123.jpg"
        XCTAssertEqual(movie.posterURL()?.absoluteString, expectedPosterURL)
    }
    
    func testPosterURLRespectsRequestedSize() {
        let movie = Movie(id: 1,
                          title: "Title",
                          overview: "Overview",
                          posterPath: "/abc123.jpg",
                          voteAverage: 8.0)
        let expectedPosterURL = "https://image.tmdb.org/t/p/w500/abc123.jpg"
        XCTAssertEqual(movie.posterURL(size: .large)?.absoluteString, expectedPosterURL)
    }

    func testPosterURLIsNilWhenPathMissing() {
        let movie = Movie(id: 1, title: "Title", overview: "Overview", posterPath: nil, voteAverage: 8.0)
        XCTAssertNil(movie.posterURL())
    }
}
