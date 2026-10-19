//
//  StaticPlaybackRepository.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 16/10/2026.
//

import Foundation

struct StaticPlaybackRepository: PlaybackRepository {
    func items(for movie: Movie) async throws -> [PlaybackItem] {
        [
            PlaybackItem(
                id: "bipbop",
                title: "Bip Bop",
                subtitle: "Episode 1",
                url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8")!
            ),
            PlaybackItem(
                id: "mux",
                title: "Mux test",
                subtitle: "Episode 2",
                url: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!
            )
        ]
    }
}
