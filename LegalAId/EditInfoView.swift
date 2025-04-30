//
//  EditInfoView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/5/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.898, green: 0.909, blue: 0.913)
    }
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var location: String = ""
    @State private var isLoading: Bool = true

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
                
                Text("Edit Information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(primaryColor)
                
                Spacer()
            }
            .padding(.horizontal, 7)
            .padding(.bottom, 50)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: primaryColor))
                    .scaleEffect(1.5)
                    .padding(.top, 100)
            } else {
                VStack(spacing: 25) {
                    inputField(icon: "person", placeholder: "FULL NAME", text: $name)
                    inputField(icon: "location", placeholder: "LOCATION", text: $location)
                    inputField(icon: "envelope", placeholder: "EMAIL", text: $email)
                    
                    GetStartedButton(
                        title: "Save Changes",
                        titleColor: .white,
                        color: primaryColor,
                        action: saveChanges
                    )
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .background(backgroundColor.ignoresSafeArea())
        .onAppear(perform: loadUserData)
    }
    
    private func loadUserData() {
        guard let user = Auth.auth().currentUser else {
            print("No user signed in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.name = data?["fullName"] as? String ?? ""
                self.location = data?["location"] as? String ?? ""
                self.email = data?["email"] as? String ?? ""
            } else {
                print("User document does not exist or error: \(error?.localizedDescription ?? "")")
            }
            self.isLoading = false
        }
    }
    
    private func saveChanges() {
        guard let user = Auth.auth().currentUser else {
            print("No user signed in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        userRef.updateData([
            "fullName": self.name,
            "location": self.location,
            "email": self.email
        ]) { error in
            if let error = error {
                print("Error updating user: \(error.localizedDescription)")
            } else {
                print("User successfully updated")
                dismiss()
            }
        }
    }
}

#Preview {
    EditInfoView()
}

private func inputField(icon: String, placeholder: String, text: Binding<String>) -> some View {
    HStack {
        Image(systemName: icon)
            .foregroundColor(.gray)
        
        TextField("", text: text, prompt: Text(placeholder).foregroundColor(.gray))
            .foregroundColor(.black)
        
        Spacer()
        
        Image(systemName: "square.and.pencil")
            .foregroundColor(.gray)
    }
    .padding()
    .background(Color.white)
    .cornerRadius(12)
    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
}
