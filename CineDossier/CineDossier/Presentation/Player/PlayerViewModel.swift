//
//  PlayerViewModel.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import Foundation

@Observable
@MainActor
final class PlayerViewModel {
    var isScrubbing: Bool = false
    var controlsVisible: Bool = true
    var errorMessage: String?
    
    private let engine: PlayerEngine
    
    private let items: [PlaybackItem]
    private var currentIndex = 0
    private(set) var currentTime: Double = .zero
    private(set) var duration: Double = .zero
    private(set) var status: PlaybackStatus = .loading
    
    var currentItem: PlaybackItem? {
        items.indices.contains(currentIndex) ? items[currentIndex] : nil
    }
    
    var upNext: PlaybackItem? {
        items.indices.contains(currentIndex + 1) ? items[currentIndex + 1] : nil
    }
    
    var isPlaying : Bool {
        status == .playing
    }
    
    init(engine: PlayerEngine, items: [PlaybackItem]) {
        self.engine = engine
        self.items = items
    }
    
    func observeEvents() async {
        for await event in engine.events {
            handle(event)
        }
    }
    
    func handle(_ event: PlayerEvent) {
        switch event {
        case .status(let value):
            status = value
            
        case .duration(let value):
            duration = value
            
        case .time(let value):
            if !isScrubbing {
                currentTime = value
            }
            
        case .didPlayToEnd:
            if let upNext {
                currentIndex += 1
                currentTime = .zero
                duration = .zero
                engine.load(url: upNext.url)
                play()
            }
            
        case .failed(let error):
            errorMessage = error.localizedDescription
        }
    }
    
    func start() {
        guard let url = currentItem?.url else { return }
        engine.load(url: url)
        engine.play()
    }
    
    func play() {
        engine.play()
    }
    
    func togglePlayPause() {
        if isPlaying {
            engine.pause()
        } else {
            engine.play()
        }
    }
    
    func stop() {
        engine.stop()
    }
}
