//
//  TikTokButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//


import SwiftUI

struct TikTokButton: View {
    var body: some View {
        Button(action: openTikTok) {
            HStack {
                Image(systemName: "music.note")
                    .foregroundColor(.white)
                Text("@theshroonsband")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [
                    Color.black,
                    Color(red: 0.00, green: 0.75, blue: 0.80), // TikTok cyan
                    Color(red: 1.00, green: 0.20, blue: 0.40)  // TikTok red/pink
                ], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }

    private func openTikTok() {
        // Deep link to open TikTok app directly to the profile
        let appURL = URL(string: "snssdk1233://user/@theshroonsband")!
        // Fallback web URL
        let webURL = URL(string: "https://www.tiktok.com/@theshroonsband")!

        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            UIApplication.shared.open(webURL)
        }
    }
}

#Preview {
    TikTokButton()
        .padding()
        .background(Color.black)
}
