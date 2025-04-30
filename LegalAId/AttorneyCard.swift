//
//  AttorneyCard.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/5/25.
//

import SwiftUI

struct AttorneyCard: View {
    let attorney: Attorney
    let secColor: Color
    let primaryColor: Color

    var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                
                    
                Text(attorney.organization_name)
                    .font(.headline)
                    .foregroundColor(primaryColor)
                    .padding(.bottom, 5)
                
                Text(attorney.services)
                    .font(.caption)
                    .foregroundColor(primaryColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Text(attorney.website)
                    .font(.footnote)
                    .italic()
                    .foregroundColor(primaryColor.opacity(0.8))
            }
            .multilineTextAlignment(.leading)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 170, maxHeight: 170, alignment: .leading, )
            .background(secColor)
            .cornerRadius(12)
    }
}

struct AttorneyDetailView: View {
    let attorney: Attorney

    var body: some View {
        VStack(spacing: 20) {
            Image("avatar")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)

            Text(attorney.organization_name)
                .font(.title)
                .fontWeight(.bold)

            Text(attorney.website)
                .font(.body)
                .padding()

            Text("Hourly Rate: $50")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle(attorney.organization_name)
    }
}
