//
//  FilterButton.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/5/25.
//

import SwiftUI

struct FilterButton: View {
    let label: String
    
    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }
    
    var body: some View {
        Button(action: {
            // Add filter logic
        }) {
            Text(label)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(primaryColor.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
