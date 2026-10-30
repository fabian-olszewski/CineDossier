//
//  LocalWatchlistRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 29/10/2026.
//

import SwiftData
import Foundation

struct LocalWatchlistRepository: WatchlistRepository {
    private let context: ModelContext
    
    init(context: ModelContext? = nil) {
        self.context = context ?? Persistence.container.mainContext
    }
    
    func items() async throws -> [Movie] {
        let descriptor = FetchDescriptor<WatchlistItemModel>(sortBy: [SortDescriptor(\.addedAt, order: .reverse)])
        return try context.fetch(descriptor).map { $0.toDomain() }
    }
    
    func add(_ movie: Movie) async throws {
        guard try await !contains(id: movie.id) else {
            return
        }
        context.insert(WatchlistItemModel(movie: movie))
        try context.save()
    }
    
    func remove(id: Int) async throws {
        let movieID = id
        let descriptor = FetchDescriptor<WatchlistItemModel>(
            predicate: #Predicate { $0.id == movieID }
        )
        for model in try context.fetch(descriptor) {
            context.delete(model)
        }
        try context.save()
    }
    
    func contains(id: Int) async throws -> Bool {
        let movieID = id
        let descriptor = FetchDescriptor<WatchlistItemModel>(
            predicate: #Predicate { $0.id == movieID }
        )
        return try context.fetchCount(descriptor) > 0
    }
    
    
}
