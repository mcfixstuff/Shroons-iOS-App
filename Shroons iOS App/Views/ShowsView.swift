import SwiftUI

struct ShowsView: View {
    @StateObject private var viewModel = ShowsViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    if viewModel.isLoading {
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.2)
                            Text("Loading Shows...")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 100)
                    } else if let error = viewModel.errorMessage {
                        VStack(spacing: 20) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.orange)
                            
                            Text("Unable to Load Shows")
                                .font(.headline)
                            
                            Text(error)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button(action: {
                                Task { await viewModel.fetchShows() }
                            }) {
                                Text("Try Again")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 140, height: 44)
                                    .background(Color.accentColor)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top, 80)
                        .padding(.horizontal, 32)
                    } else {
                        LazyVStack(spacing: 32, pinnedViews: []) {
                            // Upcoming Shows Section
                            if !viewModel.upcoming.isEmpty {
                                LazyVStack(alignment: .leading, spacing: 16, pinnedViews: []) {
                                    HStack {
                                        Image(systemName: "calendar.badge.clock")
                                            .foregroundColor(.accentColor)
                                        Text("Upcoming Shows")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Spacer()
                                        Text("\(viewModel.upcoming.count)")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.secondary)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color(.systemGray5))
                                            .cornerRadius(8)
                                    }
                                    .padding(.horizontal, 20)
                                    // Lazy stack (Only load needed shows)
                                    LazyVStack(spacing: 12) {
                                        ForEach(viewModel.upcoming) { show in
                                            NavigationLink(destination: ShowDetailView(show: show)) {
                                                ShowCard(show: show)
                                                    .foregroundColor(.primary)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            
                            // Past Shows Section
                            if !viewModel.past.isEmpty {
                                LazyVStack(alignment: .leading, spacing: 16, pinnedViews: []) {
                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.secondary)
                                        Text("Past Shows")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Spacer()
                                        Text("\(viewModel.past.count)")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.secondary)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color(.systemGray5))
                                            .cornerRadius(8)
                                    }
                                    .padding(.horizontal, 20)
                                    
                                    LazyVStack(spacing: 12) {
                                        ForEach(viewModel.past) { show in
                                            NavigationLink(destination: ShowDetailView(show: show)) {
                                                ShowCard(show: show)
                                                    .foregroundColor(.primary)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            
                            // Empty state if no shows
                            if viewModel.upcoming.isEmpty && viewModel.past.isEmpty {
                                VStack(spacing: 16) {
                                    Image(systemName: "calendar.badge.exclamationmark")
                                        .font(.system(size: 60))
                                        .foregroundColor(.secondary)
                                    
                                    Text("No Shows Scheduled")
                                        .font(.headline)
                                    
                                    Text("Check back soon for upcoming performances!")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.top, 100)
                                .padding(.horizontal, 32)
                            }
                        }
                        .padding(.vertical, 20)
                    }
                }
                .refreshable {
                    await viewModel.fetchShows()
                }
            }
            .navigationTitle("Shows")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.fetchShows()
            }
        }
    }
}

#Preview {
    ShowsView()
}
