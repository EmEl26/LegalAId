//
//  ChangePassView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/10/25.
//

import SwiftUI
import FirebaseAuth

struct ChangePassView: View {
    @Environment(\.dismiss) var dismiss
    
    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.898, green: 0.909, blue: 0.913)
    }
    
    @State private var oldPassword: String = ""
    @State private var newPassword1: String = ""
    @State private var newPassword2: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .padding(2)
                }
                
                Spacer()
                
                Text("Change Password")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(primaryColor)
                
                Spacer()
            }
            .padding(.horizontal, 7)
            .padding(.bottom, 50)
            
            VStack(spacing: 25) {
                secureInputField(placeholder: "OLD PASSWORD", text: $oldPassword)
                secureInputField(placeholder: "NEW PASSWORD", text: $newPassword1)
                secureInputField(placeholder: "CONFIRM NEW PASSWORD", text: $newPassword2)
                
                GetStartedButton(
                    title: "Save Changes",
                    titleColor: .white,
                    color: primaryColor,
                    action: changePassword
                )
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .background(backgroundColor.ignoresSafeArea())
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(isSuccess ? "Success" : "Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess {
                        dismiss()
                    }
                }
            )
        }
    }
    
    private func changePassword() {
        guard !oldPassword.isEmpty, !newPassword1.isEmpty, !newPassword2.isEmpty else {
            alertMessage = "Please fill in all fields."
            isSuccess = false
            showingAlert = true
            return
        }
        
        guard newPassword1 == newPassword2 else {
            alertMessage = "New passwords do not match."
            isSuccess = false
            showingAlert = true
            return
        }

        if let validationError = validatePassword(newPassword1) {
            alertMessage = validationError
            isSuccess = false
            showingAlert = true
            return
        }
        
        guard let user = Auth.auth().currentUser, let email = user.email else {
            alertMessage = "User not logged in."
            isSuccess = false
            showingAlert = true
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)
        user.reauthenticate(with: credential) { result, error in
            if let error = error {
                alertMessage = "Incorrect old password: \(error.localizedDescription)"
                isSuccess = false
                showingAlert = true
                return
            }

            user.updatePassword(to: newPassword1) { error in
                if let error = error {
                    alertMessage = "Failed to update password: \(error.localizedDescription)"
                    isSuccess = false
                } else {
                    alertMessage = "Password changed successfully!"
                    isSuccess = true
                }
                showingAlert = true
            }
        }
    }
}

#Preview {
    ChangePassView()
}

private func secureInputField(placeholder: String, text: Binding<String>) -> some View {
    HStack {
        SecureField(placeholder, text: text)
            .foregroundColor(.black)
        
        Spacer()
    }
    .padding()
    .background(Color.white)
    .cornerRadius(12)
    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
}

func validatePassword(_ password: String) -> String? {
    if password.count < 6 {
        return "Password must be at least 6 characters long."
    }
    
    let specialCharacterPattern = ".*[^A-Za-z0-9].*"
    let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterPattern)
    
    if !specialCharacterPredicate.evaluate(with: password) {
        return "Password must contain at least one special character (e.g., !@#$%^&*)."
    }
    
    return nil // Password is valid
}

