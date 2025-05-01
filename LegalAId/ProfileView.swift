import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var navigateToContentView = false
    @State private var showDeleteConfirmation = false
    @State private var isDeleting = false

    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }

    private var backgroundColor: Color {
        Color(red: 0.898, green: 0.910, blue: 0.914)
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(primaryColor)
                    .padding(.horizontal, 7)
                    .padding(.bottom)

                Text(authViewModel.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(primaryColor)
                    .padding(.bottom, 1)

                Text(authViewModel.email)
                    .font(.title2)
                    .padding(.bottom)

                VStack(spacing: 12) {
                    NavigationLink(destination: PreferencesView()) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(primaryColor)
                                .bold()
                            Text("Preferences")
                                .foregroundColor(primaryColor)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(backgroundColor)
                        .cornerRadius(10)
                    }

                    // Logout Button
                    Button(action: {
                        authViewModel.logout()
                        navigateToContentView = true
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(primaryColor)
                                .bold()
                            Text("Logout")
                                .foregroundColor(primaryColor)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(backgroundColor)
                        .cornerRadius(10)
                    }
                    .padding(.top, 20)

                    // Delete Account Button
                    Button(action: {
                        showDeleteConfirmation = true
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .bold()
                            Text("Delete Account")
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(backgroundColor)
                        .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .font(.title3)
                .bold()
                
                .padding(.horizontal, 30)
                .padding(.bottom, 10)

                Spacer()
            }
            .onAppear {
                authViewModel.fetchUserData()
            }
            .background(backgroundColor.ignoresSafeArea())
            .navigationDestination(isPresented: $navigateToContentView) {
                AppView()
                    .environmentObject(authViewModel)
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Delete Account"),
                    message: Text("Are you sure you want to permanently delete your account? This cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteAccount()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func deleteAccount() {
        isDeleting = true
        guard let user = Auth.auth().currentUser else { return }

        let db = Firestore.firestore()
        db.collection("users").document(user.uid).delete { error in
            if let error = error {
                print("Error deleting Firestore data: \(error.localizedDescription)")
                isDeleting = false
                return
            }

            user.delete { error in
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                    isDeleting = false
                } else {
                    authViewModel.logout()
                    navigateToContentView = true
                }
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthViewModel())
}
