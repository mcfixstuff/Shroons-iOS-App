//
//  GalleryDetailView.swift
//  Shroons iOS App
//
//  Created by Eric on 10/25/25.
//



import SwiftUI

struct GalleryDetailView: View {
    let collection: GalleryCollection
    @State private var images: [String] = []
    @State private var isLoading = true
    @State private var selectedImage: String? = nil
    @State private var showFullImage = false

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading photos...")
                    .padding()
            } else if images.isEmpty {
                Text("No images found.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(images, id: \.self) { img in
                        Button {
                            selectedImage = img
                            showFullImage = true
                        } label: {
                            AsyncImage(url: URL(string: "https://shroons.com" + img)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .aspectRatio(3/2, contentMode: .fit)
                                    .cornerRadius(12)
                                    .overlay(ProgressView())
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(collection.name)
        .task {
            await fetchImages()
        }
        .sheet(isPresented: $showFullImage) {
            if let img = selectedImage {
                SinglePhotoView(imageURL: "https://shroons.com" + img)
            }
        }
    }

    // MARK: - Load Images for this Collection
    private func fetchImages() async {
        guard let url = URL(string: "https://shroons.com/api/gallery/\(collection.name)/") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([String].self, from: data)
            images = decoded
        } catch {
            print("Failed to load collection images: \(error)")
        }
        isLoading = false
    }
}

#Preview {
    GalleryDetailView(
        collection: GalleryCollection(name: "Halloween", thumbnail: "/media/gallery/thumb.jpg")
    )
}
