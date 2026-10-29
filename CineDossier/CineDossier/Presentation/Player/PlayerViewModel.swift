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
    private let autoHideDelay: Duration
    private let items: [PlaybackItem]
    private let upNextTreshold: Double
    private var isUpNextDismissed = false
    private var currentIndex = 0
    private var hideTask: Task<Void, Never>?
    private(set) var currentTime: Double = .zero
    private(set) var duration: Double = .zero
    private(set) var status: PlaybackStatus = .loading
    private(set) var shouldClose = false
    
    var isUpNextVisible: Bool {
        upNext != nil
            && !isUpNextDismissed
            && !isScrubbing
            && duration > 0 ? duration - currentTime <= upNextTreshold : false
    }
    
    var upNextSecondsRemaining: Int {
        max(0, Int((duration - currentTime).rounded(.up)))
    }
    
    var currentItem: PlaybackItem? {
        items.indices.contains(currentIndex) ? items[currentIndex] : nil
    }
    
    var upNext: PlaybackItem? {
        items.indices.contains(currentIndex + 1) ? items[currentIndex + 1] : nil
    }
    
    var isPlaying : Bool {
        status == .playing
    }
    
    init(engine: PlayerEngine,
         items: [PlaybackItem],
         autoHideDelay: Duration = .seconds(3),
         upNextTreshold: Double = 15.0) {
        self.engine = engine
        self.items = items
        self.autoHideDelay = autoHideDelay
        self.upNextTreshold = upNextTreshold
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
            if upNext != nil, !isUpNextDismissed {
                advance()
            } else {
                close()
            }
            
        case .failed(let error):
            errorMessage = error.localizedDescription
        }
    }
    
    func start() {
        guard let url = currentItem?.url else { return }
        engine.load(url: url)
        engine.play()
        scheduleAutoHide()
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
    
    func toggleControls() {
        controlsVisible ? hideControls() : showControls()
    }
    
    func showControls() {
        controlsVisible = true
        scheduleAutoHide()
    }
    
    func beginScrubbing() {
        if isPlaying {
            engine.pause()
        }
        isScrubbing = true
        hideTask?.cancel()
    }

    func scrub(to seconds: Double) {
        currentTime = seconds
    }

    func endScrubbing() async {
        await engine.seek(to: currentTime)
        isScrubbing = false
        if !isPlaying {
            engine.play()
        }
        scheduleAutoHide()
    }
    
    func stop() {
        engine.stop()
    }
    
    func dismissUpNext() {
        isUpNextDismissed = true
    }
    
    func playNextNow() {
        advance()
    }
    
    private func advance() {
        guard let next = upNext else { return }
        currentIndex += 1
        currentTime = 0
        duration = 0
        isUpNextDismissed = false
        engine.load(url: next.url)
        engine.play()
    }
    
    private func close() {
        shouldClose = true
    }
    
    private func hideControls() {
        hideTask?.cancel()
        controlsVisible = false
    }
    
    private func scheduleAutoHide() {
        hideTask?.cancel()
        guard !isScrubbing else { return }
        hideTask = Task { [weak self, autoHideDelay] in
            try? await Task.sleep(for: autoHideDelay)
            guard !Task.isCancelled else { return }
            self?.controlsVisible = false
        }
    }
}
