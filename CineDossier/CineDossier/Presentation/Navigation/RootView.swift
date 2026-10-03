//
//  RootView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import SwiftUI

struct RootView: View {
    @State private var showOnboarding: Bool = false
    
    var body: some View {
        Group {
            if showOnboarding {
                // show onboarding
            } else {
                MainTabView()
            }
        }
    }
}

#Preview {
    RootView()
}
