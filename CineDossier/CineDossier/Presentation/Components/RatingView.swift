//
//  RatingView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 22/09/2026.
//

import SwiftUI

struct RatingView: View {
    let ratingValue: Double
    
    var body: some View {
        if ratingValue > 0 {
            (Text("★ ").foregroundStyle(Color.accent) +
             Text(String(format: "%.1f", ratingValue))
                .foregroundStyle(.textSecondary))
                .font(.subheadline)
        } else {
            Text("No ratings")
                .foregroundStyle(.textSecondary)
                .font(.subheadline)
        }
    }
}

#Preview("Rating non-zero") {
    RatingView(ratingValue: 8.1)
}

#Preview("Rating zero") {
    RatingView(ratingValue: 0)
}
