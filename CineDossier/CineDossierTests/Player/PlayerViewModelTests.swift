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
        return (PlayerViewModel(engine: engine, items: items), engine)
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
    
    func testSetDuration() {
        let itemA = PlaybackItem.stub()
        let itemB = PlaybackItem.stub()
        let (viewModel, _) = makeSUT(items: [itemA, itemB])
        let duration = 150.0
        
        viewModel.start()
        viewModel.handle(.duration(duration))
        XCTAssertEqual(viewModel.duration, duration)
    }
}
