//
//  Persistence.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 29/10/2026.
//

import SwiftData

struct Persistence {
    private init() {}
    
    static let container: ModelContainer = {
        try! ModelContainer(for: WatchlistItemModel.self)
    }()
}
