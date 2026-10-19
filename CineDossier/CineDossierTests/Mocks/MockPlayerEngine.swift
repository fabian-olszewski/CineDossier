//
//  MockPlayerEngine.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import Foundation
@testable import CineDossier

class MockPlayerEngine: PlayerEngine {
    let events: AsyncStream<PlayerEvent>
    private let continuation: AsyncStream<PlayerEvent>.Continuation
    
    private(set) var loadedURLs: [URL] = []
    private(set) var playCallCount = 0
    private(set) var pauseCallCount = 0
    private(set) var seeks: [Double] = []
    
    init() {
        let asyncStream = AsyncStream.makeStream(of: PlayerEvent.self)
        events = asyncStream.stream
        continuation = asyncStream.continuation
    }
    
    func load(url: URL) {
        loadedURLs.append(url)
    }
    
    func play() {
        playCallCount += 1
    }
    
    func pause() {
        pauseCallCount += 1
    }
    
    func stop() {}
    
    func seek(to seconds: Double) async {
        seeks.append(seconds)
    }
    
    func send(_ event: PlayerEvent) {
        continuation.yield(event)
    }
}
