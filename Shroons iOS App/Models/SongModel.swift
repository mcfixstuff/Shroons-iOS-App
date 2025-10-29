//
//  Song.swift
//  Shroons iOS App
//
//  Created by Eric on 10/29/25.
//

import Foundation

struct Song: Identifiable {
    let id = UUID().uuidString
    let title: String
    let artist: String
    let spotifyURL: URL
    let previewURL: URL
    let artworkURL: URL?
}
