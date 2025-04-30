//
//  SingleCaseView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/4/25.
//

import SwiftUI

struct SingleCase: Identifiable {
    let id = UUID()
    let title: String
    let lawyer: String
    let description: String
    let date: Date
    let icon: String
    let status: String
}

struct SingleCaseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    let chosenCase: Case
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(primaryColor)
                                .padding()
                        }
                        Spacer()
                    }
                    
                    Image(chosenCase.imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Text(chosenCase.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(primaryColor)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        Text("11/11/11 •")
                        Text("Name, Name •")
                        Text(chosenCase.status)
                    }
                    .foregroundColor(Color(red: 0.674, green: 0.678, blue: 0.725))
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(chosenCase.question)
                    .foregroundColor(primaryColor)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(backgroundColor.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
        }
    }

#Preview {
    SingleCaseView(chosenCase: Case(name: "TikTok vs. Congress", question: "Lorem aute aute elit in aute deserunt labore adipisicing ea id tempor tempor sint mollit.", status: "Ongoing", imageName: "law2"))
}
