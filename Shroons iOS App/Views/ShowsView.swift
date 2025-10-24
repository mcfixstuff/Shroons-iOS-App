import SwiftUI

struct ShowsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background image for the glass effect
                Image("concertBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        
                        ForEach(Show.sampleShows) { show in
                            ShowCard(show: show)
                                .frame(maxWidth: 400)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Upcoming Shows")
        }
    }
}

#Preview {
    ShowsView()
}
