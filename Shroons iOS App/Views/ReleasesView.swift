//
//  ReleasesView.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//

import SwiftUI

struct ReleasesView: View {
    let songs = [
        Song(
            title: "Nerve",
            artist: "The Shroons",
            spotifyURL: URL(string: "https://open.spotify.com/track/1d0JlbMJlpXHyc0RxSddsD")!,
            previewURL: URL(string: "https://shroons.com/media/songs/Nerve.mp3")!,
            artworkURL: URL(string: "https://shroons.com/media/artwork/surfing_in_the_rain.jpg")
        ),
        Song(
            title: "Midnight Drive",
            artist: "The Shroons",
            spotifyURL: URL(string: "https://open.spotify.com/track/2abc123...")!,
            previewURL: URL(string: "https://shroons.com/media/previews/midnight_drive.mp3")!,
            artworkURL: nil
        )
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(songs) { song in
                    SpotifyPreviewButton(song: song)
                }
            }
            .padding()
        }
    }
}
