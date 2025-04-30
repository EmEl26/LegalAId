//
//  LegalResourceCard.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/5/25.
//
import SwiftUI


// have to make all of the cards uniform height
struct LegalResourceCard: View {
    let resource: LegalResource
    let secColor: Color
    let primaryColor: Color
    let heightVal: Int
    
    var body: some View {
        VStack {
            Image(systemName: resource.icon)
                .font(.title2)
                .foregroundColor(primaryColor)
                .padding(.bottom,2)
            
            Text(resource.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(primaryColor)
                .padding(.bottom,2)
            
            Text(resource.description)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(primaryColor.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: CGFloat(heightVal), maxHeight: CGFloat(heightVal))
        .background(secColor)
        .cornerRadius(12)
    }
}

struct LegalResourceDetailView: View {
    let resource: LegalResource
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: resource.icon)
                .font(.largeTitle)
            Text(resource.title)
                .font(.title)
                .bold()
            Text(resource.description)
                .padding()
            Spacer()
        }
        .padding()
        .navigationTitle(resource.title)
    }
}
