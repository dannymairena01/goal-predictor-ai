import Foundation

// MARK: - App Models (Used in Views)

struct Player: Identifiable, Codable {
    let id: UUID
    let name: String
    let team: String
    let imageName: String
    let recentForm: String
    let seasonStats: String
    let nextOpponent: String
    let nextMatchId: UUID
}

struct Match: Identifiable, Codable {
    let id: UUID
    let homeTeam: String
    let awayTeam: String
    let date: Date
    let venue: String
}

struct Prediction: Identifiable, Codable {
    let id: UUID
    let playerId: UUID
    let probability: Double
    let reasoning: String
    let confidentYes: Bool
    let timestamp: Date
}

// MARK: - TheSportsDB Response Models

struct TheSportsDBPlayerResponse: Codable {
    let player: [TheSportsDBPlayer]?
}

struct TheSportsDBPlayer: Codable {
    let idPlayer: String
    let strPlayer: String
    let strTeam: String?
    let strThumb: String?
    let strPosition: String?
    let strNationality: String?
    let strDescriptionEN: String?
}
