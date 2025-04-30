import SwiftUI

struct QuestionBubble: View {
    let text: String

    private var bubbleColor: Color {
        Color(red: 0.24313725490196078, green: 0.2980392156862745, blue: 0.3764705882352941)
    }

    var body: some View {
        Text(text)
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(bubbleColor)
            .cornerRadius(15)
    }
}
