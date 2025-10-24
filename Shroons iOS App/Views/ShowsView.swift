import SwiftUI

struct ShowsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("No upcoming shows yet.")
                        .navigationTitle("Upcoming Shows")
                }
            }
        }
    }
}

#Preview {
    ShowsView()
}
