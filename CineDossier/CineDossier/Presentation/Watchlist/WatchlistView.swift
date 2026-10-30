//
//  WatchlistView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import SwiftUI

struct WatchlistView: View {
    
    @State
    private var viewModel: WatchlistViewModel
    
    init(viewModel: WatchlistViewModel = WatchlistViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationDestination(for: Movie.self) { movie in
                    DetailsView(movie: movie)
                }
        }
    }
    
    private var contentView: some View {
        Group {
            if let errorMessage = viewModel.errorMessage {
                ErrorStateView(errorMessage: errorMessage) {
                    Task {
                        await viewModel.loadWatchlistItems()
                    }
                }
            } else if viewModel.isLoading && viewModel.movies.isEmpty {
                ProgressView()
            } else if !viewModel.movies.isEmpty {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())]) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(value: movie) {
                                MovieCellView(movie: movie)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top)
                }
            } else {
                emptyWatchlist
            }
        }
        .navigationTitle("Watchlist")
        .task {
            await viewModel.loadWatchlistItems()
        }
    }
    
    private var emptyWatchlist: some View {
        ContentUnavailableView {
            Label("Your watchlist is empty", systemImage: "bookmark")
        } description: {
            Text("Movies you save will show up here.")
        }
    }
    
}

#Preview {
    WatchlistView()
}
