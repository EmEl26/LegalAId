import SwiftUI

struct ResponseBubble: View {
    let response: String

    private var borderColor: Color {
        Color(red: 0.22, green: 0.33, blue: 0.42)
    }
    
    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .bold()
                    .padding()
                    .background(Color.white).opacity(0.3)
                    .cornerRadius(10)
                Spacer()
                Image(systemName: "doc.on.doc")
                Image(systemName: "bookmark")
                Image(systemName: "square.and.arrow.up")
            }
            .font(.subheadline)
            .foregroundColor(primaryColor)
            
            Spacer()

            Text(.init(response))
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color(red: 0.8470588235294118, green: 0.8862745098039215, blue: 0.9019607843137255))
    }
}
