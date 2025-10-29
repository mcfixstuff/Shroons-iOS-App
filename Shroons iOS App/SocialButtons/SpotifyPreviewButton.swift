//
//  SpotifyPreviewButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/29/25.
//


import SwiftUI
import AVFoundation

struct SpotifyPreviewButton: View {
    let song: Song
    @State private var player: AVPlayer?
    @State private var isPlaying = false

    var body: some View {
        HStack(spacing: 12) {
            // Album Art
            AsyncImage(url: song.artworkURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }

            // Song Info
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            // Play/Pause button
            Button(action: togglePlayback) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.green)
            }
        }
        .padding(12)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .onTapGesture {
            // Open Spotify track when tapped (not the play button)
            UIApplication.shared.open(song.spotifyURL)
        }
        .onDisappear {
            stopPlayback()
        }
    }

    private func togglePlayback() {
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            if player == nil {
                player = AVPlayer(url: song.previewURL)
            }
            player?.play()
            isPlaying = true
        }
    }

    private func stopPlayback() {
        player?.pause()
        player = nil
        isPlaying = false
    }
}
