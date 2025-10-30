//
//  RetryAsyncImage.swift
//  Shroons iOS App
//
//  Created by Eric on 10/30/25.
//
import SwiftUI

struct RetryAsyncImage: View {
    let url: URL
    let maxRetries: Int
    let retryDelay: TimeInterval

    @State private var retryCount = 0
    @State private var refreshID = UUID() // triggers AsyncImage reload

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                if retryCount < maxRetries {
                    Color.clear
                        .onAppear {
                            retryCount += 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + retryDelay) {
                                refreshID = UUID() // force reload
                            }
                        }
                } else {
                    // fallback image if retries failed
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
            @unknown default:
                EmptyView()
            }
        }
        .id(refreshID) // changing ID forces AsyncImage to reload
    }
}
