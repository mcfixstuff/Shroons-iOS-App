import SwiftUI

struct YouTubeButton: View {
    var channelHandle: String
    var label: String {
        "@\(channelHandle)"
    }

    var body: some View {
        Button(action: openYouTube) {
            HStack {
                Image(systemName: "play.rectangle.fill")
                    .foregroundColor(.white)
                Text(label)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [
                    Color.red,
                    Color(red: 0.8, green: 0, blue: 0)
                ], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }

    private func openYouTube() {
        // Deep link to open directly in the YouTube app
        let appURL = URL(string: "youtube://www.youtube.com/\(label)")!
        // Fallback to the web URL
        let webURL = URL(string: "https://www.youtube.com/\(label)")!

        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            UIApplication.shared.open(webURL)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        YouTubeButton(channelHandle: "theshroons")
        YouTubeButton(channelHandle: "TheShroonsVault")
    }
    .padding()
    .background(Color.black)
}
