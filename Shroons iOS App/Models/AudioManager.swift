//
//  AudioManager.swift
//  Shroons iOS App
//
//  Created by Eric on 10/29/25.
//


import Foundation
import AVFoundation
import Combine
@MainActor
final class AudioManager: ObservableObject {
    static let shared = AudioManager()
    private var player: AVPlayer?
    @Published var currentlyPlayingID: String? = nil

    private init() {}

    func play(songID: String, url: URL) {
        // If the same song is tapped again, stop it
        if currentlyPlayingID == songID {
            stop()
            return
        }

        // Stop any existing playback
        stop()

        // Start new playback
        player = AVPlayer(url: url)
        player?.play()
        currentlyPlayingID = songID
    }

    func stop() {
        player?.pause()
        player = nil
        currentlyPlayingID = nil
    }

    func isPlaying(_ id: String) -> Bool {
        return currentlyPlayingID == id
    }
}
