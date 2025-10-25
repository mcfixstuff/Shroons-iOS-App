import SwiftUI

struct GalleryDetailView: View {
    let collection: GalleryCollection
    @State private var images: [String] = []
    @State private var isLoading = true

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
                        NavigationLink(
                            destination: SinglePhotoView(imageURL: "https://shroons.com" + img),
                            label: {
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
                        )
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
    }

    // MARK: - Load Images for this Collection
    private func fetchImages() async {
        guard let encodedCollectionName = collection.name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://shroons.com/api/gallery/photos/\(encodedCollectionName)/") else {
            print("Invalid URL for collection: \(collection.name)")
            isLoading = false
            return
        }

        do {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .returnCacheDataElseLoad
            let session = URLSession(configuration: config)
            let (data, _) = try await session.data(from: url)
            print("Received data for URL: \(url)") // Debug
            let decoded = try JSONDecoder().decode(PhotosResponse.self, from: data)
            await MainActor.run {
                images = decoded.photos
                isLoading = false
            }
        } catch {
            print("Failed to load collection images: \(error)")
            await MainActor.run {
                isLoading = false
            }
        }
    }
}

// MARK: - Models
struct PhotosResponse: Codable {
    let photos: [String]
}

#Preview {
    GalleryDetailView(
        collection: GalleryCollection(name: "Halloween", thumbnail: "/media/gallery/thumbnail.jpg")
    )
}

