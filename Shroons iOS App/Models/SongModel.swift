//
//  Song.swift
//  Shroons iOS App
//
//  Created by Eric on 10/29/25.
//

import SwiftUI

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let spotifyURL: URL
    let previewURL: URL   // your hosted MP3
    let artworkURL: URL?  // optional album art
}
