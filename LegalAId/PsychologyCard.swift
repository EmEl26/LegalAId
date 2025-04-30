//
//  PsychologyCard.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/4/25.
//

import SwiftUI

struct PsychologyCard: View {
    let psychologyItem: PsychologySupport
    let primColor: Color
    let secColor: Color
    
    var body: some View {
        NavigationLink(destination: SinglePsychView(psychologyItem: psychologyItem)) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(psychologyItem.organization_name)
                        .font(.headline)
                        .foregroundColor(primColor)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Text(psychologyItem.general_info)
                        .font(.subheadline)
                        .foregroundColor(primColor)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Text("\(Image(systemName: "pin")) \(psychologyItem.address)")
                        .font(.subheadline)
                        .foregroundColor(primColor)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(secColor)
                .cornerRadius(10)
//                .overlay(
//                    Text("0.2 m")
//                        .font(.caption2)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                        .background(Color.red.opacity(0.3))
//                        .cornerRadius(10)
//                        .foregroundColor(.black)
//                        .padding(8),
//                    alignment: .topTrailing
//                )
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            
        }
    }
}

#Preview {
    PsychologyCard(psychologyItem: PsychologySupport(organization_name: "NYC Health + Hospitals/Jacobi - Behavioral Health Services", address: "3900 Broadway, New York, NY 10027",general_info: """
                                                     Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos. 

                                                     Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
                                                                                                   
                                                     Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
                                             """), primColor:
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
                   , secColor: Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627))
}
    
    struct PsychologyCard2: View {
        let psych: PsychologySupport
        let secColor: Color
        let primaryColor: Color
        
        var body: some View {
            VStack {
                Text(psych.organization_name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(primaryColor)
                    .padding(.bottom, 2)
                
                Text(psych.general_info)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(primaryColor)
                    .padding(.bottom, 2)
                
                Text(psych.address)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(primaryColor)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 170, maxHeight: 170)
            .background(secColor)
            .cornerRadius(12)
        }
    }


