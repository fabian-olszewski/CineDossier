//
//  MovieCellView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 11/08/2026.
//

import SwiftUI

struct MovieCellView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: movie.posterURL()) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                LinearGradient(colors: [Color.surfaceSecondary,
                                        Color.surfacePrimary,
                                        Color.backgroundPrimary],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            }
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(movie.title)
                .foregroundStyle(.textPrimary)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
            
            RatingView(ratingValue: movie.voteAverage)
        }
        //.padding(.horizontal)
    }
}

#Preview {
    MovieCellView(movie: Movie.samples.first!)
}
