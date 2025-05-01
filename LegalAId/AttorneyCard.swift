import SwiftUI

struct AttorneyCard: View {
    let attorney: Attorney
    let secColor: Color
    let primaryColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(attorney.organization_name)
                .font(.headline)
                .foregroundColor(primaryColor)
                .padding(.bottom, 5)

            Text(attorney.services)
                .font(.caption)
                .foregroundColor(primaryColor)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text(attorney.website)
                .font(.footnote)
                .italic()
                .foregroundColor(primaryColor.opacity(0.8))

            Spacer()

            // Tags section
            HStack {
                ForEach(attorney.tags, id: \.self) { tag in
                    TagView(tag: tag, primaryColor: primaryColor)
                }
            }
            .padding(.top, 10)
        }
        .multilineTextAlignment(.leading)
        .padding()
        .frame(maxWidth: .infinity, minHeight: 170, maxHeight: 170, alignment: .leading)
        .background(secColor)
        .cornerRadius(12)
    }
}


struct TagView: View {
    let tag: String
    let primaryColor: Color

    @State private var isTapped = false // State to track if the tag is tapped
    
    private var circleColor: Color {
        // Customize the color for each tag
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
        VStack {
            // Colored Circle for tag
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

struct AttorneyDetailView: View {
    let attorney: Attorney

    var body: some View {
        VStack(spacing: 20) {
            Image("avatar")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)

            Text(attorney.organization_name)
                .font(.title)
                .fontWeight(.bold)

            Text(attorney.website)
                .font(.body)
                .padding()

            Text("Hourly Rate: $50")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle(attorney.organization_name)
    }
}
