//
//  PlayerViewModelTests.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import XCTest
@testable import CineDossier

extension PlaybackItem {
    static func stub(
        id: String = "\(UUID())",
        title: String = "Stub title",
        subtitle: String? = nil,
        url: URL = URL(string: "https://example.com/\(UUID().uuidString).m3u8")!
    ) -> PlaybackItem {
        PlaybackItem(id: id, title: title, subtitle: subtitle, url: url)
    }
}

@MainActor
final class PlayerViewModelTests: XCTestCase {
    private func makeSUT(items: [PlaybackItem]) -> (PlayerViewModel, MockPlayerEngine) {
        let engine = MockPlayerEngine()
        return (PlayerViewModel(engine: engine, items: items, autoHideDelay: .milliseconds(20)), engine)
    }
    
    func testDidPlayToEndLoadNextItem() {
        let itemA = PlaybackItem.stub()
        let itemB = PlaybackItem.stub()
        let (viewModel, engine) = makeSUT(items: [itemA, itemB])
        
        viewModel.start()
        viewModel.handle(.didPlayToEnd)
        XCTAssertEqual(viewModel.currentItem, itemB)
        XCTAssertNil(viewModel.upNext)
        XCTAssertEqual(engine.loadedURLs, [itemA.url, itemB.url])
    }
    
    func testStartLoadsFirstElement() {
        let itemA = PlaybackItem.stub()
        let (viewModel, engine) = makeSUT(items: [itemA])
        
        viewModel.start()
        XCTAssertEqual(engine.loadedURLs, [itemA.url])
        XCTAssertEqual(engine.playCallCount, 1)
    }
    
    func testPlayToEndOnLastElementDoesNotPlayNext() {
        let itemA = PlaybackItem.stub()
        let itemB = PlaybackItem.stub()
        let (viewModel, engine) = makeSUT(items: [itemA, itemB])
        
        viewModel.start()
        viewModel.handle(.didPlayToEnd)
        viewModel.handle(.didPlayToEnd)
        XCTAssertEqual(engine.playCallCount, 2)
    }
    
    func testIfTimeEventIsIgnoredWhenScrubbing() {
        let itemA = PlaybackItem.stub()
        let itemB = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA, itemB])
        let newTime = 5.0
        
        viewModel.start()
        viewModel.isScrubbing = true
        viewModel.handle(.time(newTime))
        XCTAssertEqual(viewModel.currentTime, .zero)
        viewModel.isScrubbing = false
        viewModel.handle(.time(newTime))
        XCTAssertEqual(viewModel.currentTime, newTime)
    }
    
    func testIsPlayingSetsStatus() {
        let itemA = PlaybackItem.stub()
        let itemB = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA, itemB])
        
        viewModel.start()
        viewModel.handle(.status(.playing))
        XCTAssertEqual(viewModel.status, .playing)
    }
    
    func testSetDurationCorrectlyWhenNotScrubbing() {
        let itemA = PlaybackItem.stub()
        let itemB = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA, itemB])
        let duration = 150.0
        
        viewModel.start()
        viewModel.handle(.duration(duration))
        XCTAssertEqual(viewModel.duration, duration)
    }
    
    func testIsPlayingIsTrueIfStatusPlayingIsSend() {
        let itemA = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA])
        
        viewModel.start()
        viewModel.handle(.status(.playing))
        XCTAssertTrue(viewModel.isPlaying)
        viewModel.handle(.status(.paused))
        XCTAssertFalse(viewModel.isPlaying)
    }
    
    func testTogglePlayPauseCallsPauseAndPlay() {
        let itemA = PlaybackItem.stub()
        let (viewModel, engine) = makeSUT(items: [itemA])
        
        viewModel.start()
        XCTAssertEqual(engine.playCallCount, 1)
        viewModel.handle(.status(.playing))
        viewModel.togglePlayPause()
        XCTAssertEqual(engine.pauseCallCount, 1)
        viewModel.handle(.status(.paused))
        viewModel.togglePlayPause()
        XCTAssertEqual(engine.playCallCount, 2)
    }
    
    func testBeginScrubbingCancelsAutohide() async throws {
        let itemA = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA])
        
        viewModel.start()
        viewModel.handle(.status(.playing))
        viewModel.beginScrubbing()
        try await Task.sleep(for: .milliseconds(100))
        XCTAssertTrue(viewModel.controlsVisible)
    }
    
    func testControlsHideAfterDelayWhilePlaying() async throws {
        let itemA = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA])
        
        viewModel.start()
        viewModel.handle(.status(.playing))
        try await Task.sleep(for: .milliseconds(100))
        XCTAssertFalse(viewModel.controlsVisible)
    }
    
    func testPlayerClosesUponReachingEndWithUpNextDismissed() {
        let itemA = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA])
        
        viewModel.start()
        viewModel.dismissUpNext()
        viewModel.handle(.didPlayToEnd)
        XCTAssertTrue(viewModel.shouldClose)
    }
}
