//
//  UpNextOverlay.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import SwiftUI

struct UpNextOverlay: View {
    let title: String
    let remainingTime: Int
    let onTapNext: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Up next")
                    .font(.caption)
                    .foregroundStyle(.textSecondary)
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundStyle(.textPrimary)
                Text("Starts in \(remainingTime) s")
                    .font(.subheadline)
                    .monospacedDigit()
                    .foregroundStyle(.textSecondary)
            }

            HStack(spacing: 12) {
                Button("Cancel", action: onDismiss)
                    .buttonStyle(CancelButtonStyle())
                Button(action: onTapNext) {
                    Label("Play", systemImage: "play.fill")
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
        .foregroundStyle(.white)
        .padding(16)
        .frame(maxWidth: 320)
        .background(LinearGradient(
            colors: [
                Color.surfaceSecondary.opacity(0.95),
                Color.backgroundPrimary.opacity(0.85)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ), in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.borderSubtle, lineWidth: 1)
        )
    }
}

#Preview {
    UpNextOverlay(title: "Django", remainingTime: 15, onTapNext: {}, onDismiss: {})
}
