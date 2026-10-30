//
//  DetailsView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 12/08/2026.
//

import SwiftUI

struct DetailsView: View {
    @State
    private var viewModel: DetailsViewModel
    
    @Environment(\.dismiss)
    private var dismiss

    private let heroHeight: CGFloat = 380
    
    init(movie: Movie) {
        self.viewModel = DetailsViewModel(movie: movie)
    }

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
        .fullScreenCover(isPresented: $viewModel.isPlayerPresented) {
            PlayerView(items: viewModel.playbackItems)
        }
        .alert("Playback failed",
               isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("Ok") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .task {
            await viewModel.loadWatchListState()
        }
    }

    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: viewModel.poster) { phase in
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
                Text(viewModel.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.textPrimary)

                RatingView(ratingValue: viewModel.averageVote)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: heroHeight)
    }

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                Task { await viewModel.didTapPlay() }
            } label: {
                if viewModel.isLoadingPlayback {
                    ProgressView().tint(Color.backgroundPrimary)
                } else {
                    Label("Play", systemImage: "play.fill")
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(viewModel.isLoadingPlayback)
            
            Button {
                Task { await viewModel.toggleWatchlist() }
            } label: {
                Label(
                    viewModel.isInWatchlist ? "In watchlist" : "Add to watchlist",
                    systemImage: viewModel.isInWatchlist ? "checkmark" : "plus"
                )
            }
            .buttonStyle(SecondaryButtonStyle())
            .padding(.bottom, 16)
            
            Text("Description")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color.textSecondary)

            Text(viewModel.description)
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
