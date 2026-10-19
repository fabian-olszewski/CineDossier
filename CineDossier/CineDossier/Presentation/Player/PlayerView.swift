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
            if [.loading, .buffering].contains(viewModel.status) {
                ProgressView()
            } else {
                playButton
            }
        }
        .background(.black)
        .overlay(alignment: .topLeading) {
            closeButton
        }
        .task {
            viewModel.start()
            await viewModel.observeEvents()
        }
        .onDisappear {
            viewModel.stop()
        }
    }
    
    private var playButton: some View {
        Button {
            viewModel.togglePlayPause()
        } label: {
            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .frame(width: 24, height: 24)
        }.tint(.textPrimary)
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(.black.opacity(0.5), in: Circle())
        }
        .padding(16)
        .accessibilityLabel("Close")
    }
    
}

#Preview {
    PlayerView(items: [])
}
