//
//  Genre.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

struct GenresResponseDTO: Decodable {
    var genres: [GenreDTO]
}

struct GenreDTO: Decodable, Identifiable, Hashable {
    var id: Int
    var name: String
}

extension GenreDTO {
    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }
}
