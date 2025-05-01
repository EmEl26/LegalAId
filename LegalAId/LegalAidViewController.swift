import SwiftUI

struct LegalAidView: View {
    @State private var questionText: String = ""
    @State private var responseText: String = "Welcome to Legal Ai(d). Ask any question about New York State or NYC laws."
    @State private var isLoading: Bool = false

    private var legalAidService = LegalAidService(apiKey: Config.anthropicApiKey) // Legal service

    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("Legal Ai(d)")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                // Scroll view for dynamic content (question & response)
                ScrollView {
                    VStack(spacing: 20) {
                        // User question input
                        HStack {
                            TextField("Ask a legal question about NY law...", text: $questionText)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: sendQuestion) {
                                Text("Send")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(5)
                            }
                        }
                        
                        // Loading indicator
                        if isLoading {
                            ProgressView("Processing your question...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        }
                        
                        // Response text
                        Text(responseText)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }

                // Reset Button
                Button(action: resetConversation) {
                    Text("Reset Conversation")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(5)
                }
                .padding()
            }
            .navigationBarTitle("Legal Ai(d)", displayMode: .inline)
        }
    }

    func sendQuestion() {
        // Validate input
        guard !questionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            responseText = "Please enter a legal question."
            return
        }

        // Start loading
        isLoading = true
        responseText = "Processing your question..."

        Task {
            do {
                // Call LegalAidService to get response from the model
                let response = try await legalAidService.sendMessage(questionText)
                responseText = response // Update the response text

                // Stop loading
                isLoading = false
                questionText = "" // Clear the input field
            } catch {
                // Handle errors
                responseText = "Error: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }

    func resetConversation() {
        // Reset conversation and clear fields
        legalAidService.resetConversation()
        responseText = "Conversation has been reset. You can ask a new question."
        questionText = ""
    }
}
