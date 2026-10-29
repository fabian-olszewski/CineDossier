//
//  Double+Extension.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 21/10/2026.
//

import Foundation

extension Double {
    var playbackTimeString: String {
        guard isFinite, self >= 0 else { return "0:00" }
        let duration = Duration.seconds(self.rounded(.down))
        return self >= 60 * 60
            ? duration.formatted(.time(pattern:
                    .hourMinuteSecond(padHourToLength: 1)))
            : duration.formatted(.time(pattern:
                    .minuteSecond(padMinuteToLength: 1)))
    }
}
