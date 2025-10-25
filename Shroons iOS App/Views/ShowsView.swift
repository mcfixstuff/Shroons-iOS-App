import SwiftUI

struct ShowsView: View {
    @StateObject private var viewModel = ShowsViewModel()
    @State private var selectedShow: Show? = nil
    @State private var isShowingDetail = false

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
                                    .onTapGesture {
                                        selectedShow = show
                                        isShowingDetail = true
                                    }
                            }
                        }

                        if !viewModel.past.isEmpty {
                            Text("Past Shows")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            ForEach(viewModel.past) { show in
                                ShowCard(show: show)
                                    .onTapGesture {
                                        selectedShow = show
                                        isShowingDetail = true
                                    }
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
            .sheet(isPresented: $isShowingDetail) {
                if let show = selectedShow {
                    ShowDetailView(show: show)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }
}

#Preview {
    ShowsView()
}
