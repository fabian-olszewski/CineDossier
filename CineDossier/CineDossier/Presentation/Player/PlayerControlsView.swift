//
//  PlayerControlsView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import SwiftUI

struct PlayerControlsView: View {
    let title: String?
    let isPlaying: Bool
    let isBusy: Bool
    let currentTime: Double
    let duration: Double
    let onClose: () -> Void
    let onTogglePlay: () -> Void
    let onScrub: (Double) -> Void
    let onScrubbingChanged: (Bool) -> Void

    var body: some View {
        ZStack {
            VStack {
                topBar
                Spacer()
                bottomBar
            }
            .padding(.horizontal)
            centerControl
        }
        .foregroundStyle(.white)
        .background { darkGradient }
        
    }
    
    var topBar: some View {
        HStack {
            closeButton
            Spacer()
        }.overlay {
            if let title {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .truncationMode(.tail)
                    .padding(.horizontal, 72)
            }
        }
    }
    
    var centerControl: some View {
        playButton
    }
    
    var bottomBar: some View {
        HStack {
            Text(currentTime.playbackTimeString)
            slider
            Text(duration.playbackTimeString)
        }
        .monospacedDigit()
    }
    
    @ViewBuilder
    private var playButton: some View {
        if isBusy {
            ProgressView()
        } else {
            Button { onTogglePlay() } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
            }.tint(.textPrimary)
        }
    }
    
    private var closeButton: some View {
        Button { onClose() } label: {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(.black.opacity(0.5), in: Circle())
        }
        .padding(16)
        .accessibilityLabel("Close")
    }
    
    private var slider: some View {
        Slider(
            value: Binding(
                get: { currentTime },
                set: { onScrub($0) }),
            in: 0...max(duration, 1),
            onEditingChanged: { editing in
                onScrubbingChanged(editing)
            }
        )
        .tint(Color.accent)
    }
    
    private var darkGradient: some View {
        ZStack {
            Color.black.opacity(0.25)
            VStack(spacing: 0) {
                LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .top, endPoint: .bottom)
                    .frame(height: 120)
                Spacer()
                LinearGradient(colors: [.clear, .black.opacity(0.7)],startPoint: .top, endPoint: .bottom)
                    .frame(height: 160)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

#Preview {
    PlayerControlsView(title: "Avengers: End Game", isPlaying: false, isBusy: true, currentTime: 10.0, duration: 200.0, onClose: {}, onTogglePlay: {}, onScrub: { _ in }, onScrubbingChanged: { _ in})
}
