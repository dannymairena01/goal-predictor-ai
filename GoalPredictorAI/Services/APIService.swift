import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(String)
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL configuration."
        case .noData: return "No data received from server."
        case .decodingError(let msg): return "Data parsing failed: \(msg)"
        case .serverError(let msg): return "Server Error: \(msg)"
        }
    }
}

class APIService {
    static let shared = APIService()
    
    // TheSportsDB Key
    private let apiKey = "123" // User provided key
    
    private var baseURL: String {
        "https://www.thesportsdb.com/api/v1/json/\(apiKey)"
    }
    
    // MARK: - Generic Request Helper
    private func fetch<T: Decodable>(endpoint: String, queryItems: [URLQueryItem], responseType: T.Type) async throws -> T {
        
        var components = URLComponents(string: baseURL + endpoint)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        print("🌍 Fetching: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError("Invalid Response")
        }
        
        if httpResponse.statusCode != 200 {
            throw APIError.serverError("Status Code: \(httpResponse.statusCode)")
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print("❌ Decoding Error: \(error)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 Raw JSON: \(jsonString)")
            }
            throw APIError.decodingError(error.localizedDescription)
        }
    }
    
    // MARK: - Public Methods
    
    // Search for a player by name
    func searchPlayer(name: String) async throws -> [Player] {
        // Endpoint: /searchplayers.php?p=Danny%20Welbeck
        let endpoint = "/searchplayers.php"
        
        let queryItems = [
            URLQueryItem(name: "p", value: name)
        ]
        
        let response = try await fetch(endpoint: endpoint, queryItems: queryItems, responseType: TheSportsDBPlayerResponse.self)
        
        guard let players = response.player else {
            return [] // No players found
        }
        
        return players.map { dbPlayer in
            return Player(
                id: UUID(), // Generate local ID
                name: dbPlayer.strPlayer,
                team: dbPlayer.strTeam ?? "Free Agent",
                imageName: "figure.soccer", // We could use dbPlayer.strThumb if we had AsyncImage
                recentForm: "Position: \(dbPlayer.strPosition ?? "Unknown")",
                seasonStats: "Nationality: \(dbPlayer.strNationality ?? "Unknown")", // TheSportsDB free tier lacks detailed live stats sometimes, using nationality/position as fallback info
                nextOpponent: "TBD", // Requires fixtures endpoint
                nextMatchId: UUID()
            )
        }
    }
}
