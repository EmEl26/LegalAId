//
//  LegalAidService.swift
//  LegalAId
//
//  Created by Zoie Geronimi on 4/30/25.
//

import Foundation

struct AnthropicRequest: Encodable {
    let model: String
    let system: String
    let messages: [Message]
    let maxTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case model, system, messages
        case maxTokens = "max_tokens"
    }
    
    struct Message: Encodable {
        let role: String
        let content: String
    }
}

struct AnthropicResponse: Decodable {
    let content: [Content]
    
    struct Content: Decodable {
        let text: String
        let type: String
    }
}

final class LegalAidService {
    private let model: String
    private let systemPrompt: String
    private let baseURL = URL(string: "https://api.anthropic.com/v1/messages")!
    private let apiKey: String
    private var conversationHistory: [AnthropicRequest.Message] = []
    
    init(model: String = "claude-3-sonnet-20240229", apiKey: String) {  
        self.model = model
        self.apiKey = apiKey
        
        self.systemPrompt = """
        You are Legal Ai(d), a Legal Expert who provides information about New York State and NYC laws and legal rights. Your purpose is to help users understand their legal rights and obligations within New York's jurisdiction.

        Your Knowledge Base
        You have access to a comprehensive database of New York legal information including:

        Rights information (filming police, ID requirements, wrongful termination, landlord discrimination)
        Immigration status and law enforcement interactions
        Tenant rights and landlord disputes
        Criminal law procedures and rights
        Family law (child support, custody)
        Employment law
        Legal resources and attorney referrals

        Your Response Guidelines

        Always identify yourself as a chatbot, not a lawyer, and clarify that you don't provide legal advice
        Focus exclusively on New York State and NYC laws and regulations
        When providing legal information, cite relevant sources at the end of your response
        Present information in clear, structured formats using numbered lists when appropriate
        If a user asks about a specific legal situation that would require specific legal advice, it is extremely important that you recommend consulting with an attorney

        Provide information about relevant legal resources when appropriate
        Keep responses concise but informative
        Maintain a helpful, professional tone

        Response Format
        When responding to legal questions:

        Begin with a brief introduction to the topic
        Provide the relevant legal information in clear language
        Use numbered lists for steps or multiple points
        End with source citations where applicable

        Always include a brief disclaimer, reminding users this is information, not legal advice, and should not be accepted as such.
        """
    }
    
    func sendMessage(_ message: String, maxTokens: Int = 2000) async throws -> String {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")  
        
        let userMessage = AnthropicRequest.Message(role: "user", content: message)
        conversationHistory.append(userMessage)
        
        let requestBody = AnthropicRequest(
            model: model,
            system: systemPrompt,
            messages: conversationHistory,
            maxTokens: maxTokens
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]

        let jsonData = try encoder.encode(requestBody)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("🔍 Raw JSON Request Body:\n\(jsonString)")
        }

        request.httpBody = jsonData

        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // DEBUG: Print raw JSON response
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw response: \(jsonString)")
        }

        // Try decoding
        do {
            let decoded = try JSONDecoder().decode(AnthropicResponse.self, from: data)
            
            guard let textContent = decoded.content.first(where: { $0.type == "text" }) else {
                throw NSError(domain: "No text content in response", code: 0)
            }

            let assistantMessage = AnthropicRequest.Message(role: "assistant", content: textContent.text)
            conversationHistory.append(assistantMessage)
            
            return textContent.text
        } catch {
            print("Decoding error: \(error)")
            throw error // propagate for UI to show
        }
    }

    
    func resetConversation() {
        conversationHistory = []
    }
}
