//
//  GalleryModel.swift
//  Shroons iOS App
//
//  Created by Eric on 10/25/25.
//

import SwiftUI
import Foundation
import Combine

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var collections: [GalleryCollection] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil

    func fetchCollections() async {
        guard let url = URL(string: "https://shroons.com/api/gallery/") else {
            errorMessage = "Invalid API URL."
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(GalleryResponse.self, from: data)
            self.collections = decoded.collections
        } catch {
            errorMessage = "Failed to load gallery: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

// MARK: - Models

struct GalleryResponse: Codable {
    let collections: [GalleryCollection]
}

struct GalleryCollection: Codable, Identifiable {
    var id: String { name }
    let name: String
    let thumbnail: String
}

