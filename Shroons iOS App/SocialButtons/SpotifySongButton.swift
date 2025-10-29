import SwiftUI

struct SpotifyPreviewButton: View {
    let song: Song
    @ObservedObject private var audioManager = AudioManager.shared

    var body: some View {
        HStack(spacing: 12) {
            // Spotify logo
            Image("Spotify")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .padding(.leading, 4)

            // Album art
            AsyncImage(url: song.artworkURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }

            // Song info
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

            // Play / pause button
            Button {
                togglePlayback()
            } label: {
                Image(systemName: audioManager.isPlaying(song.id) ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.green)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(UIColor.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.green.opacity(0.4), lineWidth: 0.6)
        )
        .onTapGesture {
            UIApplication.shared.open(song.spotifyURL)
        }
    }

    private func togglePlayback() {
        if audioManager.isPlaying(song.id) {
            audioManager.stop()
        } else {
            audioManager.play(songID: song.id, url: song.previewURL)
        }
    }
}
