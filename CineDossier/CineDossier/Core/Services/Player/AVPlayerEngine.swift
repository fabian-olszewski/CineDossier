//
//  AVPlayerEngine.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import AVKit

final class AVPlayerEngine: PlayerEngine {
    private let continuation: AsyncStream<PlayerEvent>.Continuation
    private var timeObserverToken: Any?
    private var playerObservations: [NSKeyValueObservation] = []
    private var itemObservations: [NSKeyValueObservation] = []
    private var didPlayToEndTask: Task<Void, Never>?
    private var lastItemStatus: AVPlayerItem.Status?
    private var lastControlStatus: AVPlayer.TimeControlStatus?
    private var lastSentStatus: PlaybackStatus?
    private var isAudioSessionConfigured = false
    
    let player = AVPlayer()
    let events: AsyncStream<PlayerEvent>
    
    init() {
        let asyncStream = AsyncStream.makeStream(of: PlayerEvent.self)
        events = asyncStream.stream
        continuation = asyncStream.continuation
        setupTimeObserver()
        setupTimeControlStatusObserver()
    }
    
    private func setupTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self, time.seconds.isFinite else { return }
            continuation.yield(.time(time.seconds))
        }
    }
    
    private func setupTimeControlStatusObserver() {
        playerObservations.append(
            player.observe(\.timeControlStatus, options: [.initial]) { [weak self] _, _ in
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    lastControlStatus = player.timeControlStatus
                    updateStatus()
                }
            }
        )
    }
    
    private func configureAudioSessionIfNeeded() {
        guard !isAudioSessionConfigured else { return }
        isAudioSessionConfigured = true
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .moviePlayback)
            try session.setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }
    
    private func setupPlayerItemObservers(item: AVPlayerItem) {
        itemObservations.append(
            item.observe(\.status, options: [.initial]) { [weak self] _, _ in
                Task { @MainActor [weak self] in
                    guard let self, let item = player.currentItem else { return }
                    lastItemStatus = item.status

                    if item.status == .failed, let error = item.error {
                        continuation.yield(.failed(error))
                    }
                    updateStatus()
                }
            }
        )
        
        itemObservations.append(
            item.observe(\.duration, options: [.initial, .new]) { [weak self] _, change in
                guard let seconds = change.newValue?.seconds, seconds.isFinite, seconds > 0 else { return }
                self?.continuation.yield(.duration(seconds))
            }
        )
        
        didPlayToEndTask = Task { [weak self] in
            let notifications = NotificationCenter.default.notifications(
                named: AVPlayerItem.didPlayToEndTimeNotification,
                object: item
            )
            for await _ in notifications {
                self?.continuation.yield(.didPlayToEnd)
            }
        }
    }
    
    private func makeStatus(item: AVPlayerItem.Status, control: AVPlayer.TimeControlStatus) -> PlaybackStatus {
        guard item == .readyToPlay else { return .loading }
        switch control {
        case .paused:
            return .paused
        case .playing:
            return .playing
        case .waitingToPlayAtSpecifiedRate:
            return .buffering
        @unknown default:
            return .paused
        }
    }
    
    private func updateStatus() {
        guard let item = lastItemStatus, let control = lastControlStatus else { return }
        let status = makeStatus(item: item, control: control)
        guard status != lastSentStatus else { return }
        lastSentStatus = status
        continuation.yield(.status(status))
    }
    
    private func removeTimeObserver() {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    func load(url: URL) {
        configureAudioSessionIfNeeded()
        itemObservations.removeAll()
        didPlayToEndTask?.cancel()
        lastItemStatus = nil
        lastSentStatus = nil
        
        let playerItem = AVPlayerItem(url: url)
        setupPlayerItemObservers(item: playerItem)
        player.replaceCurrentItem(with: playerItem)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func stop() {
        pause()
        player.replaceCurrentItem(with: nil)
        removeTimeObserver()
        playerObservations.removeAll()
        itemObservations.removeAll()
        didPlayToEndTask?.cancel()
        continuation.finish()
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func seek(to seconds: Double) async {
        let time = CMTime(seconds: seconds, preferredTimescale: 600)
        await player.seek(to: time)
    }
}
