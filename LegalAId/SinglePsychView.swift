//
//  SinglePsychView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/4/25.
//

import SwiftUI

struct SinglePsychView: View {
    let psychologyItem: PsychologySupport
    
    private var primaryColor: Color {
            Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    
    private var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }
    
    private func color(for tag: String) -> Color {
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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
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
                
                SupportsMapView(supports: [psychologyItem])
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Text("\(psychologyItem.organization_name)")
                    .font(.title)
                    .bold()
                    .foregroundColor(primaryColor)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("\(Image(systemName: "pin")) \(psychologyItem.address)")
                    .foregroundColor(primaryColor)

                Spacer()
                
                if !psychologyItem.tags.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        VStack(spacing: 8) {
                            ForEach(psychologyItem.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 15)
                                    .background(color(for: tag))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 10)
                    }
                    .padding()
                    .background(backgroundColor)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 10)
                }

                
                Text(psychologyItem.general_info)
                    .foregroundColor(primaryColor)
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(backgroundColor.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SinglePsychView(psychologyItem: PsychologySupport(organization_name: "Furnald Support Center",
        address: "3900 Broadway, New York, NY 10027",
        general_info: """
        Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos. 

        Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
                                                      
        Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
""", tags: []))
}
