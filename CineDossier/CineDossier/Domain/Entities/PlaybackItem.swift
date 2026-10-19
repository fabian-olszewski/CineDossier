//
//  PlaybackItem.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import Foundation

struct PlaybackItem: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String?
    let url: URL
}
