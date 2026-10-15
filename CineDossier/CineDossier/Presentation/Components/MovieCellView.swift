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
            Color.clear
                .aspectRatio(2/3, contentMode: .fit)
                .overlay {
                    AsyncImage(url: movie.posterURL()) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        LinearGradient(colors: [Color.surfaceSecondary,
                                                Color.surfacePrimary,
                                                Color.backgroundPrimary],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(movie.title)
                .foregroundStyle(.textPrimary)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)

            RatingView(ratingValue: movie.voteAverage)
        }
    }
}

#Preview {
    MovieCellView(movie: Movie.samples.first!)
}
