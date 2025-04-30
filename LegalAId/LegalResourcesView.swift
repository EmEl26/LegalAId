//
//  LegalResourcesView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/3/25.
//

import SwiftUI

struct LegalResource: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
}

struct LegalResourcesView: View {
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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let resources: [LegalResource] = [
        LegalResource(title: "Sample Wills", description: "What to do if you are called into questioning.", icon: "exclamationmark.triangle"),
        LegalResource(title: "Defense Strategy", description: "The realities of tax avoidance and evasion.", icon: "building.columns"),
        LegalResource(title: "Plaintiff Guidelines", description: "What to do if you are called into questioning.", icon: "exclamationmark.triangle"),
        LegalResource(title: "Sample Wills", description: "What to do if you are called into questioning.", icon: "exclamationmark.triangle"),
        LegalResource(title: "Defense Strategy", description: "The realities of tax avoidance and evasion.", icon: "building.columns"),
        LegalResource(title: "Plaintiff Guidelines", description: "What to do if you are called into questioning.", icon: "exclamationmark.triangle"),
        LegalResource(title: "Sample Wills", description: "What to do if you are called into questioning.", icon: "exclamationmark.triangle"),
        LegalResource(title: "Defense Strategy", description: "The realities of tax avoidance and evasion.", icon: "building.columns"),
        LegalResource(title: "Plaintiff Guidelines", description: "What to do if you are called into questioning.", icon: "exclamationmark.triangle"),
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
                    }
                    
                    Spacer()
                    
                    Text("Legal Resources")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        FilterButton(label: "All")
                        FilterButton(label: "Personal Rights")
                        FilterButton(label: "Free Resources")
                    }
                    .padding(.horizontal)
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(resources) { resource in
                            NavigationLink(destination: SingleLegalView( legalRes: resource)) {
                                LegalResourceCard(resource: resource, secColor: secColor, primaryColor: primaryColor, heightVal: 180)
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(backgroundColor.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
        }
    }
}
        

#Preview {
    LegalResourcesView()
}
