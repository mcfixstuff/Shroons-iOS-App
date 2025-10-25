//
//  SinglePhotoView.swift
//  Shroons iOS App
//
//  Created by Eric on 10/25/25.
//

import SwiftUI
import PhotosUI

struct SinglePhotoView: View {
    let imageURL: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()

            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            } placeholder: {
                ProgressView().tint(.white)
            }

            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                    }

                    Spacer()

                    Button {
                        saveToPhotos()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }

    // MARK: - Save Image to Photos
    func saveToPhotos() {
        guard let url = URL(string: imageURL) else { return }
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                }
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
}

#Preview {
    SinglePhotoView(imageURL: "https://shroons.com/media/gallery/70's%20Shoot/_DSC4871.jpg")
}
