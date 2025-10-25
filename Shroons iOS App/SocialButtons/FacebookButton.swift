import SwiftUI

struct FacebookButton: View {
    var body: some View {
        Button(action: openFacebook) {
            HStack {
                Image(systemName: "f.circle.fill")
                    .foregroundColor(.white)
                Text("TheShroons")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [
                    Color(red: 0.23, green: 0.35, blue: 0.60), // dark blue
                    Color(red: 0.40, green: 0.60, blue: 0.95)  // light blue
                ], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }

    private func openFacebook() {
        let appURL = URL(string: "fb://profile/TheShroons")!
        let webURL = URL(string: "https://www.facebook.com/TheShroons")!

        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            UIApplication.shared.open(webURL)
        }
    }
}

#Preview {
    FacebookButton()
        .padding()
        .background(Color.black)
}
