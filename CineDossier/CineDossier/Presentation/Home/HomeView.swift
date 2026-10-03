//
//  HomeView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading, viewModel.movies.isEmpty {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage, viewModel.movies.isEmpty {
                    contentUnavailableView(errorMessage)
                } else {
                    contentView
                }
            }
            .padding(.horizontal, 16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if #available(iOS 26.0, *) {
                    ToolbarItem(placement: .principal) {
                        BrandTitleView()
                    }
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        BrandTitleView()
                    }
                }
                
            }
            .toolbarRole(.editor)
            .navigationDestination(for: Genre.self) { genre in
                GenreCollectionView(genre: genre)
            }
            .navigationDestination(for: Movie.self) { movie in
                DetailsView(movie: movie)
            }.task {
                await viewModel.loadContent()
            }
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 24) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.genres) { genre in
                            NavigationLink(value: genre) {
                                GenreCardView(genre: genre)
                            }
                            .containerRelativeFrame(.horizontal, count: 3, spacing: 12)
                        }
                    }
                }
                if !viewModel.movies.isEmpty {
                    LazyVGrid(columns: [GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())]) {
                        Section(header:
                            Text("Trending")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ) {
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(value: movie) {
                                    MovieCellView(movie: movie)
                                }
                            }
                        }
                    }
                }
            }
        }
        .refreshable {
            await viewModel.loadContent()
        }
    }
    
    private func contentUnavailableView(_ errorMessage: String) -> some View {
        ContentUnavailableView {
            Label("Something went wrong", systemImage: "exclamationmark.triangle")
        } description: {
            Text(errorMessage)
        } actions: {
            Button("Try again") {
                Task {
                    await viewModel.loadContent()
                }
            }
        }
    }
    
}

#Preview {
    HomeView()
}
