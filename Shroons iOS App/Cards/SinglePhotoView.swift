import SwiftUI
import PhotosUI

struct SinglePhotoView: View {
    let imageURL: String
    @State private var isSaved = false
    @State private var showingSaveError = false
    @State private var saveErrorMessage = ""

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()

            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                case .failure:
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                            .font(.largeTitle)
                        Text("Failed to load image")
                            .foregroundColor(.white)
                            .padding()
                    }
                case .empty:
                    ProgressView().tint(.white)
                @unknown default:
                    ProgressView().tint(.white)
                }
            }

            HStack {
                Spacer()
                VStack {
                    if isSaved {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                            .padding()
                    } else {
                        Button(action: {
                            print("Tapped Save to Photos for image: \(imageURL)") // Debug
                            saveToPhotos()
                        }) {
                            Image(systemName: "square.and.arrow.down")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding()
                        }
                    }
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
            }
        }
        .navigationBarBackButtonHidden(false) // Ensure back button is visible
        .alert("Error", isPresented: $showingSaveError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(saveErrorMessage)
        }
    }

    // MARK: - Save Image to Photos
    private func saveToPhotos() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                Task {
                    do {
                        guard let url = URL(string: imageURL) else {
                            await MainActor.run {
                                saveErrorMessage = "Invalid image URL."
                                showingSaveError = true
                            }
                            return
                        }
                        let config = URLSessionConfiguration.default
                        config.requestCachePolicy = .returnCacheDataElseLoad
                        let session = URLSession(configuration: config)
                        let (data, _) = try await session.data(from: url)
                        guard let uiImage = UIImage(data: data) else {
                            await MainActor.run {
                                saveErrorMessage = "Failed to process image data."
                                showingSaveError = true
                            }
                            return
                        }
                        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                        await MainActor.run {
                            isSaved = true // Switch to checkmark
                            print("Image saved successfully: \(imageURL)") // Debug
                        }
                    } catch {
                        await MainActor.run {
                            saveErrorMessage = "Error saving image: \(error.localizedDescription)"
                            showingSaveError = true
                        }
                    }
                }
            case .denied, .restricted:
                Task { @MainActor in
                    saveErrorMessage = "Photo library access denied. Please enable it in Settings."
                    showingSaveError = true
                }
            default:
                Task { @MainActor in
                    saveErrorMessage = "Unable to save image. Please try again."
                    showingSaveError = true
                }
            }
        }
    }
}

#Preview {
    SinglePhotoView(imageURL: "https://shroons.com/media/gallery/70's%20Shoot/_DSC4871.jpg")
}
