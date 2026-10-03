//
//  DetailsView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 12/08/2026.
//

import SwiftUI

struct DetailsView: View {
    let movie: Movie
    @Environment(\.dismiss) private var dismiss

    private let heroHeight: CGFloat = 380

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                heroSection
                overviewSection
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.backgroundPrimary)
        .toolbar(.hidden, for: .tabBar)
    }

    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: movie.posterURL(size: .large)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    posterPlaceholder(icon: "photo")
                default:
                    posterPlaceholder(icon: nil)
                }
            }
            .frame(height: heroHeight)
            .frame(maxWidth: .infinity)
            .clipped()

            LinearGradient(
                colors: [.clear, Color.backgroundPrimary.opacity(0.9), Color.backgroundPrimary],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: heroHeight)

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                RatingView(ratingValue: movie.voteAverage)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 18)
        }
        .frame(height: heroHeight)
    }

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Opis")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color.textSecondary)

            Text(movie.overview)
                .font(.body)
                .foregroundStyle(Color.textPrimary)
                .lineSpacing(4)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 28)
    }

    private func posterPlaceholder(icon: String?) -> some View {
        ZStack {
            LinearGradient(
                colors: [Color.surfaceSecondary, Color.surfacePrimary, Color.backgroundPrimary],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            if let icon {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundStyle(Color.textSecondary)
            }
        }
    }
}

#Preview {
    DetailsView(movie: Movie.sample)
}
