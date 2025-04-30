import SwiftUI

struct ChatBotView: View {
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = []

    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }

    private var backgroundColor: Color {
        Color(red: 0.898, green: 0.91, blue: 0.914)
    }

    private var bubbleColor: Color {
        Color(red: 0.22, green: 0.33, blue: 0.42)
    }

    var body: some View {
        VStack {
            // Top Bar
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(primaryColor)
                        .padding()
                        
                }

                Spacer()
                Text("Chat")
                    .font(.title2)
                    .foregroundColor(Color(red: 0.49019607843137253, green: 0.5254901960784314, blue: 0.5764705882352941))
                Spacer()

                Image(systemName: "ellipsis")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color(red: 0.49019607843137253, green: 0.5254901960784314, blue: 0.5764705882352941))
            }

            Spacer(minLength: 10)

            if messages.isEmpty {
            Text("Legal Ai(d)")
                .font(.title)
                .foregroundColor(primaryColor)
                .bold()
                .padding(.bottom)

                VStack(spacing: 12) {
                    QuestionBubble(text: "Is it legal to record a conversation without the other person's consent?")
                    QuestionBubble(text: "Can a landlord enter my apartment without giving prior notice?")
                    QuestionBubble(text: "Is it legal to resell concert or sports tickets at a higher price?")
                    QuestionBubble(text: "Are businesses required to accept cash payments?")
                }
                .padding(.horizontal)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(messages) { message in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Spacer()
                                    ChatQuestionView(question: message.question)
                                }

                                HStack {
                                    ResponseBubble(response: message.response)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }

            Spacer()

            HStack {
                TextField("Send a message.", text: $messageText, onCommit: {
                    sendMessage()
                })
                .foregroundColor(primaryColor)
                .padding()

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(primaryColor)
                        .padding(10)
                        .clipShape(Circle())
                }
                
            }
            .background(Color(red: 0.796078431372549, green: 0.8392156862745098, blue: 0.8509803921568627))
            .cornerRadius(10)
            .padding()
        }
        .background(backgroundColor.ignoresSafeArea())
    }

    func sendMessage() {
        let trimmed = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let response = generateResponse(for: trimmed)
        messages.append(ChatMessage(question: trimmed, response: response))
        messageText = ""
    }

    func generateResponse(for input: String) -> String {
        return """
        Dressing appropriately for court is important as it reflects respect for the legal process and can influence how you're perceived.

        **General Tips:**
        1. **Dress Conservatively**: Choose attire that is modest and professional.
        2. **Keep It Simple**: Avoid flashy or distracting outfits.
        3. **Grooming Matters**: Ensure your hair is neat, and if applicable, your makeup and accessories are understated.
        """
    }
}

#Preview {
    ChatBotView()
}
