import SwiftUI

struct AttorneysView: View {
    @Environment(\.dismiss) var dismiss
    @State private var attorneys: [Attorney] = []
    @State private var selectedFilters: Set<String> = []

    private var primaryColor: Color {
        Color(red: 0.0784313725490196, green: 0.1450980392156863, blue: 0.24313725490196078)
    }

    private var backgroundColor: Color {
        Color(red: 0.8980392156862745, green: 0.9098039215686274, blue: 0.9137254901960784)
    }

    private var secColor: Color {
        Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627)
    }
    
    private var veterans: Color {
        Color(hue: 0.339, saturation: 0.866, brightness: 0.574)
    }
    
    private var public_benefits: Color {
        Color(hue: 0.642, saturation: 0.501, brightness: 0.98)
    }
    
    private var allTags: [String] {
        let tags = attorneys.flatMap { $0.tags }
        return Array(Set(tags)).sorted()
    }

    private var filteredAttorneys: [Attorney] {
        if selectedFilters.isEmpty {
            return attorneys
        } else {
            return attorneys.filter { attorney in
                !selectedFilters.isDisjoint(with: attorney.tags)
            }
        }
    }

    private func color(for tag: String) -> Color {
        switch tag.lowercased() {
        case "civil legal services":
            return .blue
        case "civil rights":
            return .mint
        case "bankruptcy":
            return .black
        case "housing and eviction":
            return .red
        case "immigration assistance":
            return .green
        case "veterans services":
            return veterans
        case "public benefits":
            return public_benefits
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
            return primaryColor
        }
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

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(allTags, id: \.self) { tag in
                            Button(action: {
                                if selectedFilters.contains(tag) {
                                    selectedFilters.remove(tag)
                                } else {
                                    selectedFilters.insert(tag)
                                }
                            }) {
                                Text(tag)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(selectedFilters.contains(tag) ? color(for: tag) : primaryColor.opacity(0.2))
                                    .foregroundColor(selectedFilters.contains(tag) ? .white : primaryColor)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 5)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(filteredAttorneys) { attorney in
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
