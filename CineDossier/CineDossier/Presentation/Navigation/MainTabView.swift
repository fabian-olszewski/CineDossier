//
//  MainTabView.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

import SwiftUI

struct MainTabView: View {
    init() {
        configureTabBarAppearance()
    }
    
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            WatchlistView().tabItem {
                Label("Watchlist", systemImage: "bookmark")
            }
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .surfacePrimary
        appearance.shadowColor = .borderSubtle

        let selected = appearance.stackedLayoutAppearance.selected
        selected.iconColor = .accent
        selected.titleTextAttributes = [.foregroundColor: UIColor.accent]

        let normal = appearance.stackedLayoutAppearance.normal
        normal.iconColor = .textSecondary
        normal.titleTextAttributes = [.foregroundColor: UIColor.textSecondary]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainTabView()
}
