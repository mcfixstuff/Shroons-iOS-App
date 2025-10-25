// Models.swift

import Foundation
import SwiftUI

// MARK: - Show Data Model
struct Show: Identifiable, Codable {
    let id: Int
    let title: String
    let location: String?
    let date_time: Date
    let additional_information: String?
    let cost: Int?
    let is_important: Bool
    let youtube_link: String?
    let poster_url: String?
    let ticket_link: String?

    var isPast: Bool { date_time < Date() }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date_time)
    }
}

struct ShowsResponse: Codable {
    let upcoming: [Show]
    let past: [Show]
}
import Combine
// MARK: - View Model
@MainActor
class ShowsViewModel: ObservableObject {
    @Published var upcoming: [Show] = []
    @Published var past: [Show] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchShows() async {
        guard let url = URL(string: "https://shroons.com/api/shows/") else { return }

        isLoading = true
        errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let response = try decoder.decode(ShowsResponse.self, from: data)

            upcoming = response.upcoming
            past = response.past
        } catch {
            print("Error fetching shows:", error)
            errorMessage = "Could not load shows."
        }

        isLoading = false
    }
}
