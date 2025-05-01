import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State var name: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State private var loginError: String?
    @State private var navigateToSignUp = false

    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }

    private var backgroundColor: Color {
        Color(red: 0.898, green: 0.910, blue: 0.914)
    }

    var isSignInButtonDisabled: Bool {
        [name, password].contains(where: \.isEmpty)
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Unlock your 24/7")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 255/255, green: 223/255, blue: 0/255))
                        .bold()
                        .tracking(-0.4)
                        .padding(.trailing, 30)
                        .padding(.horizontal, 35)
                        .padding(.bottom, 90)
                    
                    Text("Legal Ai(d)")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0/255, green: 0/255, blue: 128/255))
                        .bold()
                        .tracking(-0.4)
                        .padding(.horizontal, 35)
                        .padding(.bottom, 90)
                }

                TextField("Name",
                          text: $name,
                          prompt: Text("\(Image(systemName: "envelope")) Enter Your Email").foregroundColor(.gray)
                )
                .padding(10)
                .background(Color(red: 0.796, green: 0.839, blue: 0.851))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                .padding(.horizontal, 35)
                .padding(.bottom, 15)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)

                HStack {
                    Group {
                        if showPassword {
                            TextField("Password", text: $password, prompt: Text("\(Image(systemName: "lock")) Password").foregroundColor(.gray))
                        } else {
                            SecureField("Password", text: $password, prompt: Text("\(Image(systemName: "lock")) Password").foregroundColor(.gray))
                        }
                    }
                    .padding(10)
                    .background(Color(red: 0.796, green: 0.839, blue: 0.851))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                    .keyboardType(.default)

                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 35)
                .padding(.bottom, 5)

                if let error = loginError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.bottom, 10)
                }

                HStack {
                    Spacer()
                    Text("Forget password?")
                        .underline()
                        .foregroundStyle(primaryColor)
                        .padding(.trailing, 35)
                }

                GetStartedButton(title: "Get Started", titleColor: .white, color: primaryColor) {
                    handleLogin()
                }
                .disabled(isSignInButtonDisabled)

                Text("Continue with Accounts")
                    .font(.body)
                    .foregroundColor(Color(red: 0.674, green: 0.678, blue: 0.725))
                    .multilineTextAlignment(.center)

                Button("Don't have an account? Sign Up") {
                    navigateToSignUp = true
                }
                .foregroundColor(primaryColor)
                .padding(.top, 20)
            }
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
        }
    }

    func handleLogin() {
        authViewModel.login(email: name, password: password)
        loginError = authViewModel.errorMessage // Capture error from AuthViewModel
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
