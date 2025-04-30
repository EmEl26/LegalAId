import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import UIKit

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
        @StateObject private var viewModel = AuthViewModel()

        @State private var email = ""
        @State private var fullName = ""
        @State private var location = ""
        @State private var password = ""
        @State private var avatarItem: PhotosPickerItem? = nil
        @State private var avatarImage: Image? = nil
        @State private var avatarData: Data? = nil
        @State private var termsAccepted = false
        @State private var showTerms = false
        @State private var isSignUpSuccessful = false
    
    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    private var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                                .padding(.horizontal, 2)
                        }

                        Spacer()

                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(primaryColor)

                        Spacer()
                    }
                    .padding(.bottom)

                    PhotosPicker(selection: $avatarItem, matching: .images, photoLibrary: .shared()) {
                        if let avatarImage = avatarImage {
                            avatarImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 130)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        } else {
                            ZStack {
                                Circle().fill(Color.gray.opacity(0.2))
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .font(.system(size: 40))
                                    .foregroundColor(primaryColor)
                            }
                            .frame(width: 150, height: 130)
                        }
                    }
                    .padding(.bottom)
                    .onChange(of: avatarItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                avatarImage = Image(uiImage: uiImage)
                            }
                        }
                    }

                    Group {
                        TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)

                        TextField("Full Name", text: $fullName)
                            .textContentType(.name)

                        TextField("Location", text: $location)
                            .textContentType(.addressCityAndState)

                        SecureField("Password", text: $password)
                            .textContentType(.newPassword)
                    }
                    .padding()
                    .foregroundColor(primaryColor)
                    .background(secColor)
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Toggle(isOn: $termsAccepted) {
                            HStack(spacing: 4) {
                                Text("I agree to the")
                                    .foregroundColor(.black)
                                Button(action: {
                                    showTerms = true
                                }) {
                                    Text("Terms & Conditions")
                                        .underline()
                                        .foregroundColor(.blue)
                                }
                                Text("of LegalAI(d)")
                                    .foregroundColor(.black)
                            }
                            .font(.subheadline)
                        }
                        .toggleStyle(iOSCheckboxToggleStyle())
                    }
                    .sheet(isPresented: $showTerms) {
                        TermsView()
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.top, 10)
                    }

                    // Sign Up Button
                    Button(action: handleSignUp) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFormValid ? primaryColor : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!isFormValid)
                    
                    // Sign In Button
                    NavigationLink(destination: LoginView(), isActive: $isSignUpSuccessful) {
                        EmptyView()
                    }
                    
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    .cornerRadius(10)
                }
                .padding()
            }
            .background(backgroundColor.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
        }
    }

    var isFormValid: Bool {
        !email.isEmpty && !fullName.isEmpty && !location.isEmpty && !password.isEmpty && termsAccepted
    }

    func handleSignUp() {
            guard isFormValid else { return }

            if let passwordError = validatePassword(password) {
                viewModel.errorMessage = passwordError
                return
            }

            Task {
                let success = await viewModel.signUp(
                    email: email,
                    password: password,
                    fullName: fullName,
                    location: location,
                    avatarData: avatarData
                )
                if success {
                    isSignUpSuccessful = true
                }
            }
        }
    
    func validatePassword(_ password: String) -> String? {
        if password.count < 6 {
            return "Password must be at least 6 characters long."
        }
        
        let specialCharacterRegex = ".*[^A-Za-z0-9].*"
        let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        if !specialCharacterTest.evaluate(with: password) {
            return "Password must include at least one special character (!@#$%^&* etc.)."
        }
        
        return nil 
    }
}

#Preview {
    SignUpView()
}
