//
//  CasesView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/4/25.
//

import SwiftUI

struct Case: Identifiable {
    let id = UUID()
    let name: String
    let question: String
    let status: String
    let imageName: String
}

struct CasesView: View {
    @Environment(\.dismiss) var dismiss
    
    private var primaryColor: Color {
            Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    
    private var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }
    
    
    private let cases: [Case] = [
            Case(name: "TikTok vs. Congress", question: "Lorem aute aute elit in aute deserunt labore adipisicing ea id tempor tempor sint mollit.", status: "Ongoing", imageName: "law2"),
            Case(name: "TikTok vs. Congress", question: "Lorem aute aute elit in aute deserunt labore adipisicing ea id tempor tempor sint mollit.", status: "Ongoing", imageName: "law2"),
            Case(name: "TikTok vs. Congress", question: "Lorem aute aute elit in aute deserunt labore adipisicing ea id tempor tempor sint mollit.", status: "Ruled", imageName: "law2"),
            Case(name: "TikTok vs. Congress", question: "Lorem aute aute elit in aute deserunt labore adipisicing ea id tempor tempor sint mollit.", status: "Ongoing", imageName: "law2"),
            Case(name: "TikTok vs. Congress", question: "Lorem aute aute elit in aute deserunt labore adipisicing ea id tempor tempor sint mollit.", status: "Ruled", imageName: "law2")
        ]
    
    var body: some View {
        NavigationStack {
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
                    
                    Text("Cases")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        FilterButton(label: "All")
                        FilterButton(label: "Personal Rights")
                        FilterButton(label: "Free Resources")
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                }
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(cases, id: \.id) { caseItem in
                            NavigationLink (destination: SingleCaseView(chosenCase: caseItem)) {
                                CaseCard(caseItem: caseItem, primColor: primaryColor, secColor: secColor)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CasesView()
}
