//
//  SpotifyButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//


//  SpotifyButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//

import SwiftUI

struct SpotifyButton: View {
    var body: some View {
        Button(action: openSpotify) {
            HStack {
                Image(systemName: "music.note.list")
                    .foregroundColor(.white)
                Text("The Shroons on Spotify")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [
                    Color.green, // Spotify green
                    Color.green.opacity(0.8)
                ], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }

    private func openSpotify() {
        let appURL = URL(string: "spotify:artist:3Xt8RaRciU609L7OCjzXX1")!
        let webURL = URL(string: "https://open.spotify.com/artist/3Xt8RaRciU609L7OCjzXX1")!

        // Try to open the Spotify app first
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            // Fallback to Safari if the app isn’t installed
            UIApplication.shared.open(webURL)
        }
    }
}

#Preview {
    SpotifyButton()
        .padding()
        .background(Color.black)
}
