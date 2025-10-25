import SwiftUI

struct ShowsView: View {
    @StateObject private var viewModel = ShowsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading Shows...")
                        .padding(.top, 50)
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            Task { await viewModel.fetchShows() }
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 24) {
                        if !viewModel.upcoming.isEmpty {
                            Text("Upcoming Shows")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            ForEach(viewModel.upcoming) { show in
                                ShowCard(show: show)
                            }
                        }

                        if !viewModel.past.isEmpty {
                            Text("Past Shows")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            ForEach(viewModel.past) { show in
                                ShowCard(show: show)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("The Shroons Shows")
            .task {
                await viewModel.fetchShows()
            }
        }
    }
}

#Preview {
    ShowsView()
}
