import Foundation

enum OpenAIError: Error {
    case invalidURL
    case noData
    case decodingError
    case apiError(String)
}

class OpenAIService {
    static let shared = OpenAIService()
    private let apiKey = "YOUR_OPENAI_API_KEY" // REPLACE WITH YOUR ACTUAL KEY
    
    private init() {}
    
    func generatePrediction(for player: Player, match: Match) async throws -> Prediction {
        let endpoint = "https://api.openai.com/v1/chat/completions"
        
        guard let url = URL(string: endpoint) else {
            throw OpenAIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let prompt = """
        Analyze if \(player.name) (\(player.team)) will score against \(match.awayTeam == player.team ? match.homeTeam : match.awayTeam) on \(match.date.formatted()).
        Player Stats: \(player.recentForm), \(player.seasonStats).
        Venue: \(match.venue).
        
        Return a JSON object with:
        - probability: Double (0.0 to 1.0)
        - reasoning: String (max 40 words, concise)
        - confidentYes: Bool (true if probability > 0.5)
        """
        
        let body: [String: Any] = [
            "model": "gpt-4-turbo-preview", // Or gpt-3.5-turbo if preferred for cost
            "messages": [
                ["role": "system", "content": "You are a soccer expert predictor. Output valid JSON only."],
                ["role": "user", "content": prompt]
            ],
            "response_format": ["type": "json_object"]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw OpenAIError.apiError("Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
        }
        
        let apiResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        guard let content = apiResponse.choices.first?.message.content,
              let data = content.data(using: .utf8) else {
            throw OpenAIError.noData
        }
        
        let result = try JSONDecoder().decode(PredictionResult.self, from: data)
        
        return Prediction(
            id: UUID(),
            playerId: player.id,
            probability: result.probability,
            reasoning: result.reasoning,
            confidentYes: result.confidentYes,
            timestamp: Date()
        )
    }
}

// MARK: - Helper Structures for Decoding

private struct OpenAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

private struct PredictionResult: Codable {
    let probability: Double
    let reasoning: String
    let confidentYes: Bool
}
