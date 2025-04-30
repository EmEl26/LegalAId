import SwiftUI

//
//  GetStartedButton.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/3/25.
//

struct GetStartedButton: View {
    var title: String
    var titleColor: Color
    var color: Color
    var action: () -> Void
        
    var body: some View {
            Button(action: action) {
                Text(title)
                    .bold()
                    .foregroundColor(titleColor)
            }
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(20)
            .padding()
        }
    }

