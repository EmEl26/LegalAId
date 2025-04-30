//
//  SingleAttorneyView.swift
//  LegalAI(d)
//
//  Created by Celia Abuin on 4/4/25.
//

import SwiftUI

struct SingleAttorneyView: View {
    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }
    
    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }
    
    let attorney: Attorney
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
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

                    Text("Attorney Profile")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(primaryColor)
                }
                .padding(.horizontal, 7)
                .padding(.bottom)
                
//                Image("avatar")
//                    .resizable()
//                    .scaledToFit()
//                    .clipShape(Circle())
//                    .frame(width: 200, height: 150)
                
                Text(attorney.organization_name)
                        .font(.title)
                        .bold()
                        .foregroundColor(primaryColor)
                        .padding(.bottom, 1)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                VStack(alignment: .center, spacing: 8) {
                    if let phone = attorney.phone {
                        HStack {
                            Image(systemName: "phone")
                            Text(phone)
                        }
                    }

                    if let hours = attorney.hours {
                        HStack {
                            Image(systemName: "clock")
                            Text(hours)
                        }
                    }

                    
                    if let instagram = attorney.instagram {
                        HStack {
                            Image(systemName: "camera")
                            Text(instagram)
                        }
                    }
                }

                    .foregroundColor(Color(red: 0.674, green: 0.678, blue: 0.725))
                    .padding(.horizontal, 25)
                    .padding(.bottom, 10)
                
                VStack(spacing: 12) {
                    NavigationLink(destination: Text("Client Ratings Details")) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "star")
                                    .foregroundColor(primaryColor)
                                    .bold()
                                Text("Client Ratings")
                                    .foregroundColor(primaryColor)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(red: 0.674, green: 0.678, blue: 0.725))
                            }
                            ProgressView(value: 0.7)
                                .foregroundColor(primaryColor)
                                .frame(maxWidth: .infinity)
                            Text("Excellent")
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        .padding()
                        .background(backgroundColor)
                        .cornerRadius(10)
                    }
                    
//                    NavigationLink(destination: Text("Submit a Case Brief Form")) {
//                        HStack {
//                            Image(systemName: "envelope.open")
//                                .foregroundColor(primaryColor)
//                                .bold()
//                            Text("Submit a Case Brief")
//                                .foregroundColor(primaryColor)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .foregroundColor(.gray)
//                        }
//                        .padding()
//                        .background(backgroundColor)
//                        .cornerRadius(10)
//                        
//                    }
                }
                
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
                Spacer()
                
                Text(attorney.services)
                .foregroundColor(primaryColor)
                .padding(.horizontal, 25)
                .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    if let address = attorney.address {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            Text(address)
                        }
                    }
                    
                    if let addresses = attorney.addresses {
                        ForEach(addresses, id: \.self) { addr in
                            HStack {
                                Image(systemName: "building.2")
                                Text(addr)
                            }
                        }
                    }
                    
                    if let offices = attorney.borough_offices {
                        VStack(alignment: .leading) {
                            Text("Borough Offices:")
                                .font(.headline)
                            ForEach(offices.sorted(by: { $0.key < $1.key }), id: \.key) { borough, number in
                                Text("\(borough): \(number)")
                            }
                        }
                    }
                }
                .foregroundColor(primaryColor)
                .padding(.horizontal, 25)

            }
        }
        .background(backgroundColor.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}


