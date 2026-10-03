//
//  MovieDTOTests.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 22/09/2026.
//

import XCTest
@testable import CineDossier

final class MovieDTOTests: XCTestCase {
    var sut: MovieDTO!
    
    override func setUp() {
        super.setUp()
        sut = MovieDTO(id: 1, title: "Movie Title", overview: "Movie overview.", posterPath: "/movie_poster.jpg", voteAverage: 8.2)
    }
    
    func testToDomainMapsAllFields() {
        let movie = sut.toDomain()
        XCTAssertEqual(sut.id, movie.id)
        XCTAssertEqual(sut.overview, movie.overview)
        XCTAssertEqual(sut.posterPath, movie.posterPath)
        XCTAssertEqual(sut.voteAverage, movie.voteAverage)
    }
}
