//
//  BrandTitleView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import SwiftUI

struct BrandTitleView: View {
    var body: some View {
        (
            Text("Cine")
                .foregroundStyle(.textPrimary)
            + Text("Dossier")
                .foregroundStyle(.accent)
        )
        .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    BrandTitleView()
}
