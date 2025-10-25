//
//  BandcampButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//


//  BandcampButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//

import SwiftUI

struct BandcampButton: View {
    var body: some View {
        Button(action: openBandcamp) {
            HStack {
                Image(systemName: "music.note") // simple icon, Bandcamp logo isn’t in SF Symbols
                    .foregroundColor(.white)
                Text("The Shroons on Bandcamp")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [
                    Color(red: 0.0, green: 0.0, blue: 0.0), // black
                    Color(red: 0.2, green: 0.2, blue: 0.2)  // dark gray
                ], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }

    private func openBandcamp() {
        let webURL = URL(string: "https://theshroons.bandcamp.com/")!

        // Bandcamp doesn’t have a dedicated URL scheme, so open in Safari
        UIApplication.shared.open(webURL)
    }
}

#Preview {
    BandcampButton()
        .padding()
        .background(Color.black)
}
