//
//  SearchView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import SwiftUI

struct SearchView: View {
    @State
    private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel = SearchViewModel()) {
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
                        await viewModel.search()
                    }
                }
            } else if viewModel.trimmedQuery.isEmpty {
                emptyQueryView
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
                ContentUnavailableView.search(text: viewModel.trimmedQuery)
            }
        }
        .navigationTitle("Search")
        .searchable(text: $viewModel.searchText)
        .task(id: viewModel.trimmedQuery) {
            await viewModel.search()
        }
    }
    
    private var emptyQueryView: some View {
        ContentUnavailableView {
            Label("Empty", systemImage: "magnifyingglass")
        } description: {
            Text("Please enter a search query.")
        }
    }
}

#Preview {
    SearchView()
}
