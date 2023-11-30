//
//  ChatGPTService.swift
//  PawinBalanceV2
//
//  Created by Cody Van Dyke on 11/28/23.
//
import Foundation

struct OpenAIResponse: Decodable {
    struct Choice: Decodable {
        struct Message: Decodable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}


struct OpenAIRequestBody: Encodable {
    let prompt: String
    let maxTokens: Int
}

struct ChatCompletionRequestBody: Encodable {
    struct Message: Encodable {
        let role: String
        let content: String
    }
    
    let model: String
    let messages: [Message]
    let temperature: Double
}

//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



class OpenAIService {
    private let apiKey = "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" // Replace with your actual API key
    private let apiUrl = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    func generateText(userInput: String, completion: @escaping (String) -> Void) {
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ChatCompletionRequestBody(
            model: "gpt-3.5-turbo",
            messages: [ChatCompletionRequestBody.Message(role: "user", content: userInput)],
            temperature: 0.7
        )
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            
            if let error = error {
                print("API Call Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received from API")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(OpenAIResponse.self, from: data),
               let responseText = decodedResponse.choices.first?.message.content {
                DispatchQueue.main.async {
                    completion(responseText)
                }
            } else {
                print("Failed to decode API response")
            }
        }.resume()
    }
}
