import FirebaseAuth
import SwiftUI
import Foundation
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isLoggingIn: Bool = false  // New state to track login progress
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var currentUser: User?
    @Published var errorMessage: String?
    
    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        listen()
    }

    /// Starts listening to Firebase authentication state changes
    func listen() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isLoggedIn = user != nil
                self.isLoggingIn = false  
            }
        }
    }
    
    

        private let db = Firestore.firestore()

        func signUp(email: String, password: String, fullName: String, location: String, avatarData: Data?) async -> Bool {
            do {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                // Update profile
                let changeRequest = result.user.createProfileChangeRequest()
                changeRequest.displayName = fullName
                try await changeRequest.commitChanges()

                // Save additional user data
                let userData: [String: Any] = [
                    "uid": result.user.uid,
                    "email": email,
                    "fullName": fullName,
                    "location": location,
                    "avatarURL": ""
                ]

                try await db.collection("users").document(result.user.uid).setData(userData)
                
                await MainActor.run {
                    self.currentUser = result.user
                    self.isLoggedIn = true
                    self.fetchUserData()
                }


                return true
            } catch {
                self.errorMessage = error.localizedDescription
                return false
            }
        }

    /// Attempts to sign out the user
    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    /// Handle login process with Firebase
    func login(email: String, password: String) {
        isLoggingIn = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoggingIn = false
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                } else {
                    print("Login successful for: \(result?.user.email ?? "")")
                    self.isLoggedIn = true
                    self.fetchUserData()
                }
            }
        }
    }

    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else {
            print("No user signed in")
            return
        }

        currentUser = user
        let userRef = db.collection("users").document(user.uid)

        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                DispatchQueue.main.async {
                    self.name = data?["fullName"] as? String ?? ""
                    self.email = data?["email"] as? String ?? ""
                }
            } else {
                print("User document does not exist or error: \(error?.localizedDescription ?? "")")
            }
        }
    }


    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
