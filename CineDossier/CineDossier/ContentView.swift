//
//  ContentView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

import SwiftUI

struct ContentView: View {
    @State var movies = ""
    
    var body: some View {
        
        return VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(movies)
            
        }
        .padding()
//        .task {
//            await getMovies()
//        }
    }
    
    private func getMovies() async {
        let service = TheMovieDatabaseAPIService()
        do {
            let movies = try await service.fetchMovieGenres()
            let titles = movies.map { $0.name }.joined(separator: "\n")
            self.movies = titles
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}


