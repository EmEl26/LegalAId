import SwiftUI

struct CaseCard: View {
    let caseItem: Case
    let primColor: Color
    let secColor: Color
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Image("law2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(caseItem.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(caseItem.question)
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
            
            Text(caseItem.status)
                .font(.caption2)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(caseItem.status == "Ongoing" ? Color.green.opacity(0.3) : Color.yellow.opacity(0.3))
                .cornerRadius(10)
                .foregroundColor(.black)
                .padding([.top, .trailing], 5)
        }
    }
}

struct CaseCard2: View {
    let caseItem: Case
    let primColor: Color
    let secColor: Color
    
    var body: some View {
                VStack(spacing: 0) {
                    Image("law2")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(16)

                    VStack {
                        Spacer(minLength: 8)
                        Text(caseItem.name)
                            .foregroundColor(primColor)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal, 4)
                        Spacer(minLength: 8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 150, height: 170)
                .background(secColor)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            }
        }
    
