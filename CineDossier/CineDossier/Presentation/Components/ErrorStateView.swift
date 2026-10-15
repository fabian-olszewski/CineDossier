//
//  ErrorStateView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 15/10/2026.
//

import SwiftUI

struct ErrorStateView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label("Something went wrong", systemImage: "exclamationmark.triangle")
        } description: {
            Text(errorMessage)
        } actions: {
            Button("Try again", action: retryAction)
        }
    }
}

#Preview {
    ErrorStateView(errorMessage: "Error msg", retryAction: {})
}
