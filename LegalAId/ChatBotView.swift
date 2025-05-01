import SwiftUI

struct ChatBotView: View {
    @State private var questionText: String = ""
    @State private var isLoading: Bool = false

    @State private var messages: [ChatMessage] = [
        ChatMessage(question: "", response: "Welcome to Legal Ai(d). Ask any question about New York State or NYC laws.")
    ]

    private var primaryColor: Color {
        Color(red: 0.078, green: 0.145, blue: 0.243)
    }

    private var backgroundColor: Color {
        Color(red: 0.898, green: 0.91, blue: 0.914)
    }

    private var legalAidService = LegalAidService(apiKey: Config.anthropicApiKey)

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
                    .foregroundColor(Color(red: 0.49, green: 0.53, blue: 0.58))
                Spacer()

                Image(systemName: "ellipsis")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color(red: 0.49, green: 0.53, blue: 0.58))
            }

            Spacer(minLength: 10)

            // ScrollView for chat messages
            ScrollView {
                VStack(spacing: 20) {
                    // Display messages
                    ForEach(messages) { message in
                        if !message.question.isEmpty {
                            ChatQuestionView(question: message.question) // Show the user's question
                        }
                        if !message.response.isEmpty {
                            ResponseBubble(response: message.response) // Show the bot's response
                        }
                    }

                    // Show loading indicator if required
                    if isLoading {
                        ProgressView("Processing your question...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .padding()
                    }
                }
            }

            Spacer()

            // Input Field and Send Button
            HStack {
                TextField("Ask a legal question about NY law...", text: $questionText, onCommit: {
                    sendQuestion()
                })
                .padding()
                .foregroundColor(primaryColor)

                Button(action: sendQuestion) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(primaryColor)
                        .padding(10)
                }
            }
            .background(Color(red: 0.796, green: 0.839, blue: 0.851))
            .cornerRadius(10)
            .padding()

            // Reset Button
            Button(action: resetConversation) {
                Text("Reset Conversation")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .background(backgroundColor.ignoresSafeArea())
    }

    func sendQuestion() {
        let trimmed = questionText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return
        }

        isLoading = true
        let question = trimmed
        questionText = ""

        // Add the user's question to the message list
        messages.append(ChatMessage(question: question, response: "Processing your question..."))
        
        Task {
            do {
                let response = try await legalAidService.sendMessage(question)
            
                if let lastMessageIndex = messages.indices.last {
                    messages[lastMessageIndex].response = response
                }
            } catch {
                
                if let lastMessageIndex = messages.indices.last {
                    messages[lastMessageIndex].response = "Error: \(error.localizedDescription)"
                }
            }
            isLoading = false
        }
    }

    func resetConversation() {
        legalAidService.resetConversation()
        messages = [ChatMessage(question: "", response: "Welcome to Legal Ai(d). Ask any question about New York State or NYC laws.")]
        questionText = ""
    }
}

#Preview {
    ChatBotView()
}
