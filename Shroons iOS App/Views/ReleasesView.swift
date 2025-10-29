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
            spotifyURL: URL(string: "https://open.spotify.com/track/347J4h7whRlX4EFFIuwA0j")!,
            previewURL: URL(string: "https://shroons.com/media/songs/Nerve.mp3")!,
            artworkURL: URL(string: "https://shroons.com/media/songs/Nerve.png")
        ),
        Song(
            title: "The Hatred",
            artist: "The Shroons",
            spotifyURL: URL(string: "https://open.spotify.com/track/3SeqIOcMzlTLJkkL3UDXvk")!,
            previewURL: URL(string: "https://shroons.com/media/songs/The%20Hatred.mp3")!,
            artworkURL: URL(string: "https://shroons.com/media/songs/The%20Hatred.jpg")!,
        ),
        Song(
            title: "Rat King",
            artist: "The Shroons",
            spotifyURL: URL(string: "https://open.spotify.com/track/5xscTBoa4N1uVWrsrJQISx")!,
            previewURL: URL(string: "https://shroons.com/media/songs/Rat%20King.mp3")!,
            artworkURL: URL(string: "https://shroons.com/media/songs/Rat%20King.png")!,
        )
    ]

    var body: some View {
        NavigationView{
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(songs) { song in
                        SpotifyPreviewButton(song: song)
                    }
                    SpotifyButton()
                }
                .padding()
            }.navigationTitle("Releases")
        }
        
    }
}
#Preview {
    ReleasesView()
}
