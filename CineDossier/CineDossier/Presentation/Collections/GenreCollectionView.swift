//
//  GenreCollectionView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 12/08/2026.
//

import SwiftUI

struct GenreCollectionView: View {
    let genre: Genre
    
    var body: some View {
        Label("Here will be movies of genre: \(genre.name)", systemImage: "film")
    }
}

#Preview {
    GenreCollectionView(genre: Genre.sample)
}

