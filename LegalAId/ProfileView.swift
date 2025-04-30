import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var navigateToContentView = false

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

//                Image("law2")
//                    .resizable()
//                    .scaledToFit()
//                    .clipShape(Circle())
//                    .frame(width: 200, height: 150)

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

//                    NavigationLink(destination: Text("Account Security Details")) {
//                        VStack(alignment: .leading, spacing: 10) {
//                            HStack {
//                                Image(systemName: "lock")
//                                    .foregroundColor(primaryColor)
//                                    .bold()
//                                Text("Account Security")
//                                    .foregroundColor(primaryColor)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(Color(red: 0.674, green: 0.678, blue: 0.725))
//                            }
//                            ProgressView(value: 0.7)
//                                .foregroundColor(primaryColor)
//                                .frame(maxWidth: .infinity)
//                            Text("Excellent")
//                                .foregroundColor(.gray)
//                                .font(.footnote)
//                        }
//                        .padding()
//                        .background(backgroundColor)
//                        .cornerRadius(10)
//                    }
//
//                    NavigationLink(destination: Text("Customer Support Details")) {
//                        HStack {
//                            Image(systemName: "questionmark.circle")
//                                .foregroundColor(primaryColor)
//                                .bold()
//                            Text("Customer Support")
//                                .foregroundColor(primaryColor)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .foregroundColor(.gray)
//                        }
//                        .padding()
//                        .background(backgroundColor)
//                        .cornerRadius(10)
//                    }

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
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthViewModel())
}
