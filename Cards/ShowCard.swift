import SwiftUI

struct ShowCard: View {
    var show: Show

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Placeholder photo
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(Color.gray.opacity(0.3))
                .clipped()

            // Show details
            VStack(alignment: .leading, spacing: 6) {
                Text(show.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                if let location = show.location {
                    Text(location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }

                Text(show.formattedDate)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                if let cost = show.cost {
                    Text("Cost: $\(cost)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                if let info = show.additionalInfo {
                    Text(info)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }

                if show.isPast {
                    Text("Past Show")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }

            Spacer(minLength: 0)

            // Optional: YouTube link indicator
            if show.youtubeLink != nil {
                Image(systemName: "play.circle.fill")
                    .foregroundStyle(.red)
                    .font(.title3)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(show.isImportant ? Color.yellow.opacity(0.7) : Color.clear, lineWidth: 2)
                )
                .shadow(radius: 4)
        )
        .frame(maxWidth: .infinity)     // Take full width safely
        .padding(.horizontal, 16)       // Single, consistent padding
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()   // Simple dark bg to test edges
        ScrollView {
            VStack(spacing: 20) {
                ForEach(Show.sampleShows) { show in
                    ShowCard(show: show)
                }
            }
            .padding(.vertical)
        }
    }
}
