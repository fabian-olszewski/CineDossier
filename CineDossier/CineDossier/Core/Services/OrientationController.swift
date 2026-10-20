//
//  OrientationController.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 20/10/2026.
//

import UIKit

@MainActor
final class OrientationController {
    static let shared = OrientationController()
    
    private(set) var mask: UIInterfaceOrientationMask = .portrait
    
    func set(_ mask: UIInterfaceOrientationMask) {
        self.mask = mask
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        scene.requestGeometryUpdate(.iOS(interfaceOrientations: mask)) { error in
            print("Orientation update error: \(error)")
        }
        scene.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
    }
}
