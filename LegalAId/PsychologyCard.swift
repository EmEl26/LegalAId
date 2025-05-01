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
                    
                    HStack {
                        ForEach(psychologyItem.tags, id: \.self) { tag in
                            TagViewPsych(tag: tag, primaryColor: primColor)
                        }
                    }
                    .padding(.top, 8)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(secColor)
                .cornerRadius(10)
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}

struct TagViewPsych: View {
    let tag: String
    let primaryColor: Color
    @State private var isTapped = false
    
    private var circleColor: Color {
        switch tag.lowercased() {
        case "adults":
            return .blue
        case "behavioral health services":
            return .black
        case "individual therapy":
            return .green
        case "group therapy":
            return .brown
        case "inpatient care":
            return .cyan
        case "inpatient services":
            return .cyan
        case "telehealth available":
            return .mint
        case "integrated legal support":
            return .teal
        case "outpatient clinics":
            return .indigo
        case "outpatient care":
            return .indigo
        case "free services":
            return .red
        case "children & adolescents":
            return .purple
        case "substance abuse treatment":
            return .orange
        case "sliding scale fees":
            return .yellow
        case "cbt":
            return .pink
        case "psychiatric services":
            return .gray
        default:
            return primaryColor
        }
    }
    
    var body: some View {
        VStack {
            Circle()
                .fill(circleColor)
                .frame(width: 10, height: 10)
                .onTapGesture {
                    withAnimation {
                        isTapped.toggle()
                    }
                }


            if isTapped {
                Text(tag)
                    .font(.caption)
                    .foregroundColor(primaryColor)
                    .padding(5)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(5)
            }
        }
    }
}



#Preview {
    PsychologyCard(psychologyItem: PsychologySupport(organization_name: "NYC Health + Hospitals/Jacobi - Behavioral Health Services", address: "3900 Broadway, New York, NY 10027",general_info: """
                                                     Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos. 

                                                     Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
                                                                                                   
                                                     Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
                                             """, tags:  ["cbt"]), primColor:
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
                
                HStack {
                    ForEach(psych.tags, id: \.self) { tag in
                        TagViewPsych(tag: tag, primaryColor: primaryColor)
                    }
                }
                .padding(.top, 8)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 170, maxHeight: 170)
            .background(secColor)
            .cornerRadius(12)
        }
    }


