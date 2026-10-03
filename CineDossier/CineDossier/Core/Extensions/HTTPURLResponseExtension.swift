//
//  HTTPURLResponseExtension.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/07/2026.
//

import Foundation

extension HTTPURLResponse {
    var isOk: Bool {
        return (200..<300).contains(statusCode)
    }
}
