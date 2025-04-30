//
//  PreferencesView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/5/25.
//

import SwiftUI


struct PreferencesView: View {
    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
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
                    
                    Text("Preferences")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 12) {
                    Preference(
                        setting: "Account Information",
                        desc: "Change your Account Information",
                        primColor: primaryColor,
                        icon: "person.fill",
                        destination: { EditInfoView() }
                    )
                    
                    Preference(
                        setting: "Password",
                        desc: "Change your Password",
                        primColor: primaryColor,
                        icon: "eye",
                        destination: { ChangePassView() }
                    )
                }

                .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
        }
    }
}

#Preview {
    PreferencesView()
}

struct Preference<Destination: View>: View {
    let setting: String
    let desc: String
    let primColor: Color
    let icon: String
    let destination: () -> Destination
    
    var body: some View {
        NavigationLink(destination: destination()) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(primColor)
                    .bold()
                    .padding()
                    .font(.title3)
                VStack(alignment: .leading, spacing: 3) {
                    Text(setting)
                        .foregroundColor(primColor)
                        .bold()
                        .font(.title3)
                        .padding(.bottom, 2)
                    Text(desc)
                }
            }
            .padding()
        }
        .accentColor(Color(red: 0.45, green: 0.45, blue: 0.45))
        .navigationBarBackButtonHidden(true)
    }
}

