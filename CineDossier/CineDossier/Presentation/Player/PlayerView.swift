//
//  PlayerView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
    @State
    private var viewModel: PlayerViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    private let player: AVPlayer
    
    init(items: [PlaybackItem]) {
        let engine = AVPlayerEngine()
        player = engine.player
        viewModel = PlayerViewModel(engine: engine, items: items)
    }
    
    var body: some View {
        ZStack {
            PlayerLayerView(player: player)
                .ignoresSafeArea()
            
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { viewModel.toggleControls() }
            
            if viewModel.isUpNextVisible, let next = viewModel.upNext {
                UpNextOverlay(title: next.title,
                              remainingTime: viewModel.upNextSecondsRemaining,
                              onTapNext: viewModel.playNextNow,
                              onDismiss: viewModel.dismissUpNext)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing, 24)
                .padding(.bottom, viewModel.controlsVisible ? 88 : 24)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
            
            PlayerControlsView(title: viewModel.currentItem?.title,
                               isPlaying: viewModel.isPlaying,
                               isBusy: [.loading, .buffering].contains(viewModel.status),
                               currentTime: viewModel.currentTime,
                               duration: viewModel.duration,
                               onClose: {
                close()
            }, onTogglePlay: {
                viewModel.togglePlayPause()
                viewModel.showControls()
            }, onScrub: {
                viewModel.scrub(to: $0)
            }, onScrubbingChanged: { editing in
                if editing {
                    viewModel.beginScrubbing()
                } else {
                    Task {
                        await viewModel.endScrubbing()
                    }
                }
            })
            .opacity(viewModel.controlsVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.25), value: viewModel.controlsVisible)
            .allowsHitTesting(viewModel.controlsVisible)
        }
        .background(.black)
        .animation(.easeInOut(duration: 0.25), value: viewModel.isUpNextVisible)
        .animation(.easeInOut(duration: 0.25), value: viewModel.controlsVisible)
        .task {
            viewModel.start()
            await viewModel.observeEvents()
        }
        .onAppear {
            OrientationController.shared.set(.allButUpsideDown)
        }
        .onChange(of: viewModel.shouldClose) { _, shouldClose in
            if shouldClose {
                close()
            }
        }
        .onDisappear {
            OrientationController.shared.set(.portrait)
            viewModel.stop()
        }
        .statusBarHidden()
        .persistentSystemOverlays(.hidden)
    }
    
    private func close() {
        OrientationController.shared.set(.portrait)
        Task {
            try? await Task.sleep(for: .milliseconds(350))
            dismiss()
        }
    }
}

#Preview {
    PlayerView(items: [])
}
