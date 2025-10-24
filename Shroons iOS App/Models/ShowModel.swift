//
//  ShowModel.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//

import Foundation

struct Show: Identifiable, Codable {
    var id = UUID()
    let title: String
    let date: Date
    let location: String?
    let additionalInfo: String?
    let cost: Int?
    let youtubeLink: URL?
    let isImportant: Bool

    /// Computed property to determine if the show is upcoming or past
    var isPast: Bool {
        return date < Date()
    }

    /// A short, formatted date string for UI display
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
}

extension Show {
    static let sampleShows: [Show] = [
        Show(
            title: "Shroonstock",
            date: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            location: "Los Angeles, CA",
            additionalInfo: "Outdoor festival — bring chairs!",
            cost: 25,
            youtubeLink: URL(string: "https://youtube.com/watch?v=dQw4w9WgXcQ"),
            isImportant: true
        ),
        Show(
            title: "Forest Vibes",
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            location: "Portland, OR",
            additionalInfo: nil,
            cost: nil,
            youtubeLink: nil,
            isImportant: false
        ),
        Show(
            title: "Mushroon Jam",
            date: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
            location: "Seattle, WA",
            additionalInfo: "21+ show — ID required",
            cost: 15,
            youtubeLink: nil,
            isImportant: true
        )
    ]
}
