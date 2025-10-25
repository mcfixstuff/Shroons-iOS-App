import SwiftUI

struct AboutView: View {
    // URL of the image
    let heroImageURL = URL(string: "https://shroons.com/media/gallery/70%27s%20Shoot/thumbnail.jpg")

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Remote image with async loading
                if let url = heroImageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 240)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 240)
                                .clipped()
                                .cornerRadius(12)
                                .padding()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 240)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                Text("About The Shroons")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("""
The Shroons are a powerhouse trio that brings the raw energy of the ’70s to the modern stage. Their original catalog is deeply rooted in the legendary sounds of rock, soul and psychedelia.
""")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    Text("The Sound")
                        .font(.headline)
                    Text("""
Blazing guitars, thunderous grooves and soulful vocals merge into something both familiar and brand new — equal parts nostalgia and freshness.
""")
                        .font(.body)

                    Text("On Stage")
                        .font(.headline)
                    Text("""
When they hit the stage, The Shroons deliver high-octane performances full of energy, improvisation and chemistry. They thrive in clubs, theaters and outdoor festival settings alike.
""")
                        .font(.body)

                    Text("Join the Experience")
                        .font(.headline)
                    Text("""
Stay tuned for upcoming shows, releases and more. The journey’s just getting started — and you’re invited.
""")
                        .font(.body)
                    InstagramButton()
                    TikTokButton()
                    YouTubeButton(channelHandle: "theshroons")
                           YouTubeButton(channelHandle: "TheShroonsVault")
                }
                .padding(.horizontal)

                Spacer(minLength: 40)
            }
            .padding(.vertical)
        }
        .navigationTitle("About")
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
