//
//  ContentView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/3/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    private var primaryColor: Color {
            Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var secColor: Color {
        Color(red: 0.43529411764705883, green: 0.43529411764705883, blue: 0.43529411764705883)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(primaryColor, lineWidth: 4)
                    }
                    .frame(width: 200, height: 200)
                Text("Welcome To")
                    .font(.largeTitle)
                    .foregroundColor(primaryColor)
                    .bold()
                    .multilineTextAlignment(.center)
                    .tracking(0.2)
                Text("Legal Ai(d)")
                    .font(.largeTitle)
                    .foregroundColor(primaryColor)
                    .multilineTextAlignment(.center)
                    .bold()
                    .tracking(0.2)
                Text("Stay informed. Stay empowered.")
                    .foregroundColor(secColor)
                    .padding(5)
                    .tracking(0.2)
                Text("Welcome to Legal Ai(d)")
                    .foregroundColor(secColor)
                    .padding(.bottom, 50)
                    .tracking(0.2)
                NavigationLink(destination: LoginView()) {
                    GetStartedButton(title: "Get Started", titleColor: .white, color: primaryColor, action: { print("button pressed") }
                    )
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
            .background(backgroundColor)
        }
    }
}
    
    #Preview {
        ContentView()
    }
