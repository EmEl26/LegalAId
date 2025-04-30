import SwiftUI

struct CaseCard3: View {
    let caseItem: CaseSummary
    let primColor: Color
    let secColor: Color

    var status: String {
        caseItem.timeline.last?.event.lowercased() ?? "unknown"
    }

    var statusColor: Color {
        switch status {
        case "granted": return Color.orange.opacity(0.3)
        case "argued": return Color.blue.opacity(0.3)
        case "decided": return Color.green.opacity(0.3)
        default: return Color.gray.opacity(0.3)
        }
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
//                Image("law2")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 100, height: 100)
//                    .cornerRadius(10)
                

                VStack(alignment: .leading, spacing: 5) {
                    Text(caseItem.name)
                        .font(.headline)
                        .fontWeight(.bold)

                    Text(caseItem.description ?? "No description available.")
                        .font(.subheadline)
                        .lineLimit(2)
                }
                .padding()
                .background(secColor)
                .foregroundColor(primColor)
                .cornerRadius(10)
            }
            .background(Color.white)
            .cornerRadius(10)

//            Text(status.capitalized)
//                .font(.caption2)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 5)
//                .background(statusColor)
//                .cornerRadius(10)
//                .foregroundColor(.black)
//                .padding([.top, .trailing], 5)
        }
    }
}

struct CaseCard4: View {
    let caseItem: CaseSummary
    let primColor: Color
    let secColor: Color

    var status: String {
        caseItem.timeline.last?.event.lowercased() ?? "unknown"
    }

    var statusColor: Color {
        switch status {
        case "granted": return Color.orange.opacity(0.3)
        case "argued": return Color.blue.opacity(0.3)
        case "decided": return Color.green.opacity(0.3)
        default: return Color.gray.opacity(0.3)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            Image("law2")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(16)

            VStack(spacing: 6) {
                Text(caseItem.name)
                    .foregroundColor(primColor)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 4)

//                Text(status.capitalized)
//                    .font(.caption2)
//                    .padding(.horizontal, 6)
//                    .padding(.vertical, 4)
//                    .background(statusColor)
//                    .cornerRadius(8)
//                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 150, height: 170)
        .background(secColor)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
