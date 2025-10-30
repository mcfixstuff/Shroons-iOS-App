import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel = GalleryViewModel()
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading gallery...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text("Error Loading Gallery")
                            .font(.headline)
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            Task { await viewModel.fetchCollections() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.collections) { collection in
                                NavigationLink(
                                    destination: GalleryDetailView(collection: collection),
                                    label: {
                                        VStack(spacing: 0) {
                                            GeometryReader { geometry in
                                                let width = geometry.size.width
                                                let height = width * 2/3 // 3:2 ratio
                                                
                                                ZStack {
                                                    if let url = URL(string: "https://shroons.com" + collection.thumbnail) {
                                                        // Use RetryAsyncImage instead of AsyncImage
                                                        RetryAsyncImage(url: url, maxRetries: 3, retryDelay: 1.5)
                                                            .frame(width: width, height: height)
                                                            .clipped()
                                                    }
                                                }
                                                .cornerRadius(12)
                                            }
                                            .aspectRatio(3/2, contentMode: .fit)
                                            
                                            Text(collection.name)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                                .lineLimit(1)
                                                .padding(.top, 6)
                                        }
                                    }
                                )
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    .navigationTitle("Gallery")
                }
            }
            .task {
                await viewModel.fetchCollections()
            }
        }
    }
}

#Preview {
    GalleryView()
}
