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
                        let smallImageURL = makeSmallVersion(of: img)
                        let baseURL = "https://shroons.com"

                        NavigationLink(
                            destination: SinglePhotoView(imageURL: baseURL + img),
                            label: {
                                // Try small version first
                                RetryAsyncImage(
                                    url: URL(string: baseURL + smallImageURL)!,
                                    maxRetries: 3,
                                    retryDelay: 1.5
                                )
                                .aspectRatio(3/2, contentMode: .fit)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                                .background(
                                    // Fallback: full image if small fails
                                    RetryAsyncImage(
                                        url: URL(string: baseURL + img)!,
                                        maxRetries: 2,
                                        retryDelay: 1.0
                                    )
                                    .aspectRatio(3/2, contentMode: .fit)
                                    .opacity(0) // invisible until needed
                                    .allowsHitTesting(false)
                                )
                                .clipped()
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

    // MARK: - Load Images
    private func fetchImages() async {
        guard let encodedName = collection.name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://shroons.com/api/gallery/photos/\(encodedName)/") else {
            await MainActor.run { isLoading = false }
            return
        }

        do {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .returnCacheDataElseLoad
            let (data, _) = try await URLSession(configuration: config).data(from: url)
            let decoded = try JSONDecoder().decode(PhotosResponse.self, from: data)
            await MainActor.run {
                images = decoded.photos
                isLoading = false
            }
        } catch {
            print("Failed to load images: \(error)")
            await MainActor.run { isLoading = false }
        }
    }

    // MARK: - Helper: Create _small version
    private func makeSmallVersion(of path: String) -> String {
        guard let dotIndex = path.lastIndex(of: ".") else { return path }
        let base = path[..<dotIndex]
        let ext = path[dotIndex...]
        return "\(base)_small\(ext)"
    }
}

// MARK: - Model
struct PhotosResponse: Codable {
    let photos: [String]
}

#Preview {
    GalleryDetailView(
        collection: GalleryCollection(name: "70's Shoot", thumbnail: "/media/gallery/70's%20Shoot/thumbnail.jpg")
    )
}
