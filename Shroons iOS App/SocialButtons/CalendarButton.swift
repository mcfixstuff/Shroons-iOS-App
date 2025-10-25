//
//  CalendarButton.swift
//  Shroons iOS App
//
//  Created by Eric on 10/25/25.
//


import SwiftUI
import EventKit

struct CalendarButton: View {
    let show: Show
    @State private var showingError = false
    @State private var errorMessage = ""

    var body: some View {
        Button(action: {
            print("Tapped Add to Calendar for show: \(show.title)") // Debug
            addToCalendar()
        }) {
            HStack {
                Image(systemName: "calendar.badge.plus")
                    .foregroundColor(.white)
                Text("Add to Calendar")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green) // Distinct color to differentiate from other buttons
            .cornerRadius(12)
        }
        .padding(.horizontal)
        .alert("Error", isPresented: $showingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }

    private func addToCalendar() {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { granted, error in
            Task { @MainActor in
                if let error = error {
                    errorMessage = "Failed to access calendar: \(error.localizedDescription)"
                    showingError = true
                    return
                }
                if !granted {
                    errorMessage = "Calendar access denied. Please enable it in Settings."
                    showingError = true
                    return
                }

                let event = EKEvent(eventStore: eventStore)
                event.title = show.title
                event.startDate = show.date_time
                event.endDate = show.date_time.addingTimeInterval(2 * 60 * 60) // Assume 2-hour event
                if let location = show.location, !location.isEmpty {
                    event.location = location
                }
                event.notes = show.additional_information ?? "No additional information."
                event.calendar = eventStore.defaultCalendarForNewEvents

                do {
                    try eventStore.save(event, span: .thisEvent)
                    print("Event saved: \(show.title)") // Debug
                } catch {
                    errorMessage = "Failed to save event: \(error.localizedDescription)"
                    showingError = true
                }
            }
        }
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
    return CalendarButton(show: sampleShow)
}