//
//  AttorneysView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/3/25.
//

import SwiftUI

struct AttorneysView: View {
    @Environment(\.dismiss) var dismiss
    @State private var attorneys: [Attorney] = []
    
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
            GridItem(.flexible())
        ]

        var body: some View {
            NavigationStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            Spacer()
                        }

                        Text("Attorneys")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(primaryColor)
                    }


//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 10) {
//                            FilterButton(label: "All")
//                            FilterButton(label: "Personal Rights")
//                            FilterButton(label: "Free Resources")
//                        }
//                        .padding(.horizontal)
//                    }

                    // Grid
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(attorneys) { attorney in
                                NavigationLink(destination: SingleAttorneyView(attorney: attorney)) {
                                    AttorneyCard(attorney: attorney, secColor: secColor, primaryColor: primaryColor)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .background(backgroundColor.ignoresSafeArea())
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    attorneys = decode_attorney("attorney_resources.json")
                
                }
            }
        }
    }

#Preview {
    AttorneysView()
}


