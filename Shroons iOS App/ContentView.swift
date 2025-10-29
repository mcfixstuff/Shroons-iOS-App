//
//  ContentView.swift
//  Shroons iOS App
//
//  Created by Eric on 10/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ShowsView()
                .tabItem {
                    Label("Shows", systemImage: "calendar")
                }
            
            GalleryView()
                .tabItem {
                    Label("Gallery", systemImage: "camera")
                }
            ReleasesView()
                .tabItem {
                    Label("Releases", systemImage: "music.note")
                }
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
