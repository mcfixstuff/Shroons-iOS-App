import SwiftUI

struct AboutView: View {
    let heroImageURL = URL(string: "https://shroons.com/media/gallery/70%27s%20Shoot/thumbnail.jpg")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero Image
                if let url = heroImageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 280)
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 280)
                                .cornerRadius(12)
                                .clipped()
                                .padding()
                        case .failure:
                            Image(systemName: "photo")
                                .font(.system(size: 60))
                                .foregroundColor(.secondary)
                                .frame(height: 280)
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                // Content
                VStack(spacing: 20) {
                    // Main Description Block
                    VStack(alignment: .leading, spacing: 12) {
                        Text("About The Shroons")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("The Shroons are a powerhouse trio that brings the raw energy of the '70s to the modern stage. Their original catalog is deeply rooted in the legendary sounds of rock, soul and psychedelia.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .padding(.horizontal, 16)
                    
                    // The Sound Block
                    InfoBlock(
                        title: "The Sound",
                        description: "Blazing guitars, thunderous grooves and soulful vocals merge into something both familiar and brand new — equal parts nostalgia and freshness."
                    )
                    
                    // On Stage Block
                    InfoBlock(
                        title: "On Stage",
                        description: "When they hit the stage, The Shroons deliver high-octane performances full of energy, improvisation and chemistry. They thrive in clubs, theaters and outdoor festival settings alike."
                    )
                    
                    // Join the Experience Block
                    InfoBlock(
                        title: "Join the Experience",
                        description: "Stay tuned for upcoming shows, releases and more. The journey's just getting started — and you're invited."
                    )
                    
                    // Social Links Block
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Connect")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            InstagramButton()
                            TikTokButton()
                            YouTubeButton(channelHandle: "theshroons")
                            YouTubeButton(channelHandle: "TheShroonsVault")
                            FacebookButton()
                            SpotifyButton()
                            BandcampButton()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 20)
                .background(Color(.systemGroupedBackground))
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Indented block component for info sections
struct InfoBlock: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
