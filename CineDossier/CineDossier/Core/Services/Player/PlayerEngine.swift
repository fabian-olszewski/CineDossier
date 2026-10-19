//
//  PlayerEngine.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import Foundation

enum PlaybackStatus: Equatable {
    case loading
    case buffering
    case playing
    case paused
}

enum PlayerEvent {
    case status(PlaybackStatus)
    case duration(Double)
    case time(Double)
    case didPlayToEnd
    case failed(Error)
}

protocol PlayerEngine: AnyObject {
    var events: AsyncStream<PlayerEvent> { get }
    
    func load(url: URL)
    func play()
    func pause()
    func stop()
    func seek(to seconds: Double) async
}
