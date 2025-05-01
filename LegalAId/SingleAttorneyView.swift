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

    private func color(for tag: String) -> Color {
        switch tag.lowercased() {
        case "civil legal services":
            return .blue
        case "housing and eviction":
            return .red
        case "immigration assistance":
            return .green
        case "criminal defense":
            return .orange
        case "children & youth":
            return .purple
        case "family law":
            return .pink
        case "low-income individuals":
            return .yellow
        case "general legal services":
            return .gray
        case "self-help resources":
            return .teal
        case "consumer rights":
            return .indigo
        case "pro bono representation":
            return .brown
        case "immigrants & refugees":
            return .cyan
        default:
            return .gray
        }
    }

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

                Text(attorney.organization_name)
                    .font(.title)
                    .bold()
                    .foregroundColor(primaryColor)
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

                if !attorney.tags.isEmpty {
                    VStack(alignment: .center, spacing: 10) {
                        VStack(spacing: 8) {
                            ForEach(attorney.tags, id: \.self) { tag in
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

