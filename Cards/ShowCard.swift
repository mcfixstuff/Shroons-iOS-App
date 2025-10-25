import SwiftUI

struct ShowCard: View {
    var show: Show
    private let baseURL = "https://shroons.com" // Base URL for your server
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            // Poster image with rounded corners
            ZStack {
                // Background placeholder
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                
                // Async image if URL is valid
                if let posterString = show.poster_url {
                    let fullURLString = posterString.starts(with: "http") ? posterString : baseURL + posterString
                    if let posterURL = URL(string: fullURLString) {
                        AsyncImage(url: posterURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipped()
                                .cornerRadius(12)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white.opacity(0.7))
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white.opacity(0.7))
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            
            // Show text details
            VStack(alignment: .leading, spacing: 6) {
                Text(show.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                
                if let location = show.location, !location.isEmpty {
                    Text(location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                
                if let info = show.additional_information, !info.isEmpty {
                    Text(info)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(radius: 4)
        )
        .padding(.horizontal, 16)
    }
}
