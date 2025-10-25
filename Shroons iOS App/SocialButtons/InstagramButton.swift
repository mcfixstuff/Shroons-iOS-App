//
//  InstagramButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//


import SwiftUI

struct InstagramButton: View {
    var body: some View {
        Button(action: openInstagram) {
            HStack {
                Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                Text("@theshroonsband")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [
                    Color(red: 0.60, green: 0.00, blue: 0.90), // purple
                    Color(red: 1.00, green: 0.30, blue: 0.50), // pink/red
                    Color.orange // orange
                ], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }

    private func openInstagram() {
        let appURL = URL(string: "instagram://user?username=theshroonsband")!
        let webURL = URL(string: "https://www.instagram.com/theshroonsband")!

        // Try to open the Instagram app first
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            // Fallback to Safari if the app isn’t installed
            UIApplication.shared.open(webURL)
        }
    }
}

#Preview {
    InstagramButton()
        .padding()
        .background(Color.black)
}
