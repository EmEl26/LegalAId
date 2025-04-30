import SwiftUI

struct AppView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if authViewModel.isLoggingIn {
                // Show a loading spinner while logging in
                ProgressView("Logging in...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if authViewModel.isLoggedIn {
                // Show TabBar if logged in
                TabBar()
            } else {
                // Show login screen if not logged in
                ContentView()
            }
        }
    }
}

#Preview {
    AppView()
}
