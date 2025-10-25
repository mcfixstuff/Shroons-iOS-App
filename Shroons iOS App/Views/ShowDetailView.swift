//
//  ShowDetailView.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//

import SwiftUI

struct ShowDetailView: View {
    var show: Show
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Poster Image
                if let posterURL = show.poster_url, let url = URL(string: posterURL) {
                    AsyncImage(url: URL(string: show.poster_url ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 200)
                            .cornerRadius(16)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.white.opacity(0.7))
                            )
                    }
                    .frame(maxWidth: .infinity)

                }

                // Title & Location
                VStack(alignment: .leading, spacing: 8) {
                    Text(show.title)
                        .font(.title)
                        .bold()
                    if let location = show.location {
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
                        Text(info)
                            .font(.body)
                    }
                    .padding(.horizontal)
                }
                
                // Cost
                if let cost = show.cost {
                    Text(cost == 0 ? "Cost: Free!" : "Cost: $\(cost)")
                        .font(.body)
                        .padding(.horizontal)
                }
                // Ticket Link
                if let ticket = show.ticket_link, let url = URL(string: ticket) {
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
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
            .padding(.top)
        }
        .presentationDetents([.fraction(0.6), .medium, .large]) // iOS 16+ / 17 bottom sheet
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    // Sample show data matching your API example
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
        ticket_link: nil
    )
    
    ShowDetailView(show: sampleShow)
}
