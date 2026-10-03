//
//  GenreCardView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 11/08/2026.
//

import SwiftUI

struct GenreCardView: View {
    let genre: Genre

    var body: some View {
        Text(genre.name)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(Color.textPrimary)
            .lineLimit(2)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 72)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(colors: [Color.surfaceSecondary,
                                                  Color.surfacePrimary,
                                                  Color.backgroundPrimary],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
            )
    }
}

#Preview {
    GenreCardView(genre: Genre.samples.first!)
}
