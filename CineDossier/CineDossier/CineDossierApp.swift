//
//  CineDossierApp.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

import SwiftUI

@main
struct CineDossierApp: App {
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
