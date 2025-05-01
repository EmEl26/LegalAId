import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    var question: String
    var response: String
}

struct ChatQuestionView: View {
    let question: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("avatar")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            HStack {
                Text(question)
                    .font(.body)
                    .foregroundColor(Color(red: 0.078, green: 0.145, blue: 0.243))
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color(red: 0.078, green: 0.145, blue: 0.243))
            }
        }
        .padding()
        .background(Color(red: 0.898, green: 0.91, blue: 0.914))
        .cornerRadius(10)
    }
}
