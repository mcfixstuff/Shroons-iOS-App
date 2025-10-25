import SwiftUI

struct ShowCard: View {
    var show: Show

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Poster image with rounded corners
            AsyncImage(url: URL(string: show.poster_url ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 80, height: 80)
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .clipped()

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
