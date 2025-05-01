import SwiftUI

struct PsychologySupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var psychologySup: [PsychologySupport] = []
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

    private var allTags: [String] {
        let tags = psychologySup.flatMap { $0.tags }
        return Array(Set(tags)).sorted()
    }

    private var filteredSupports: [PsychologySupport] {
        if selectedFilters.isEmpty {
            return psychologySup
        } else {
            return psychologySup.filter { item in
                !selectedFilters.isDisjoint(with: item.tags)
            }
        }
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

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()

                VStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                                .padding(2)
                        }

                        Spacer()

                        Text("Psychology Support")
                            .font(.title)
                            .foregroundColor(primaryColor)
                            .fontWeight(.bold)

                        Spacer()
                    }
                    .padding(.horizontal)

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
                        SupportsMapView(supports: filteredSupports)
                            .cornerRadius(10)
                            .padding(.horizontal)

                        LazyVStack(spacing: 10) {
                            ForEach(filteredSupports) { psychologySup in
                                PsychologyCard(psychologyItem: psychologySup, primColor: primaryColor, secColor: secColor)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .onAppear {
                    psychologySup = decode_psych("psychology-resources.json")
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    PsychologySupView()
}
