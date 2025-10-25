import SwiftUI

struct ShowDetailView: View {
    var show: Show
    private let baseURL = "https://shroons.com"

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Poster Image (only if available)
                if let posterString = show.poster_url {
                    let fullURLString = posterString.starts(with: "http") ? posterString : baseURL + posterString
                    if let posterURL = URL(string: fullURLString) {
                        AsyncImage(url: posterURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(16)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 250)
                        }
                        .padding(.horizontal)
                    }
                }

                // Title & Location
                VStack(alignment: .leading, spacing: 8) {
                    Text(show.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary) // Ensure black text

                    if let location = show.location, !location.isEmpty {
                        Text(location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Text(show.formattedDate)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                // Additional Information
                if let info = show.additional_information, !info.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Additional Information")
                            .font(.headline)
                            .foregroundColor(.primary) // Ensure black text
                        Text(info)
                            .font(.body)
                            .foregroundColor(.primary) // Ensure black text
                    }
                    .padding(.horizontal)
                }

                // Cost
                if let cost = show.cost {
                    Text(cost == 0 ? "Cost: Free!" : "Cost: $\(cost)")
                        .font(.body)
                        .foregroundColor(.primary) // Ensure black text
                        .padding(.horizontal)
                }

                // Add to Calendar Button
                if !show.isPast { // Only for upcoming shows
                    CalendarButton(show: show)
                }

                // Ticket Link (only for upcoming shows)
                if !show.isPast, let ticket = show.ticket_link, let url = URL(string: ticket) {
                    Link(destination: url) {
                        Text("Purchase Tickets")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }

                // YouTube Link
                if let yt = show.youtube_link, let url = URL(string: yt) {
                    Link(destination: url) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(.red)
                            Text("Watch on YouTube")
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }

                Spacer(minLength: 40)
            }
            .padding(.top)
        }
        .navigationTitle(show.title)
        .navigationBarBackButtonHidden(false) // Ensure back button is visible
    }
}

#Preview {
    let sampleShow = Show(
        id: 71,
        title: "Halloween Show",
        location: "TBA",
        date_time: ISO8601DateFormatter().date(from: "2025-11-01T02:00:00+00:00") ?? Date(),
        additional_information: "TBA",
        cost: 0,
        is_important: false,
        youtube_link: nil,
        poster_url: nil,
        ticket_link: "https://shroons.com/tickets/halloween"
    )
    return ShowDetailView(show: sampleShow)
}
