import Foundation

class DataService {
    static let shared = DataService()
    
    // MARK: - 2025/2026 Season - Top 30 In-Form Players (Top 5 Leagues)
    // Updated: February 2026
    
    let players: [Player] = [
        // --- Premier League (England) ---
        Player(id: UUID(), name: "Erling Haaland", team: "Man City", imageName: "figure.soccer", recentForm: "Hat-trick vs Arsenal", seasonStats: "28 Goals / 24 Matches", nextOpponent: "Liverpool", nextMatchId: UUID()),
        Player(id: UUID(), name: "Mohamed Salah", team: "Liverpool", imageName: "figure.run", recentForm: "Goal & 2 Assists vs Spurs", seasonStats: "22 Goals / 25 Matches", nextOpponent: "Man City", nextMatchId: UUID()),
        Player(id: UUID(), name: "Cole Palmer", team: "Chelsea", imageName: "figure.soccer", recentForm: "4 goals in last 3", seasonStats: "18 Goals / 24 Matches", nextOpponent: "Newcastle", nextMatchId: UUID()),
        Player(id: UUID(), name: "Bukayo Saka", team: "Arsenal", imageName: "figure.run", recentForm: "Scored vs Brighton", seasonStats: "14 Goals / 25 Matches", nextOpponent: "Man United", nextMatchId: UUID()),
        Player(id: UUID(), name: "Alexander Isak", team: "Newcastle", imageName: "figure.soccer", recentForm: "Brace vs West Ham", seasonStats: "19 Goals / 23 Matches", nextOpponent: "Chelsea", nextMatchId: UUID()),
        Player(id: UUID(), name: "Son Heung-min", team: "Tottenham", imageName: "figure.run", recentForm: "Goal vs Villa", seasonStats: "16 Goals / 24 Matches", nextOpponent: "Everton", nextMatchId: UUID()),
        
        // --- La Liga (Spain) ---
        Player(id: UUID(), name: "Kylian Mbappé", team: "Real Madrid", imageName: "figure.soccer", recentForm: "Hat-trick vs Mallorca", seasonStats: "26 Goals / 23 Matches", nextOpponent: "Barcelona", nextMatchId: UUID()),
        Player(id: UUID(), name: "Vinicius Junior", team: "Real Madrid", imageName: "figure.run", recentForm: "Scored vs Sevilla", seasonStats: "20 Goals / 24 Matches", nextOpponent: "Barcelona", nextMatchId: UUID()),
        Player(id: UUID(), name: "Robert Lewandowski", team: "Barcelona", imageName: "figure.soccer", recentForm: "Brace vs Valencia", seasonStats: "24 Goals / 23 Matches", nextOpponent: "Real Madrid", nextMatchId: UUID()),
        Player(id: UUID(), name: "Jude Bellingham", team: "Real Madrid", imageName: "figure.run", recentForm: "2 goals vs Atletico", seasonStats: "15 Goals / 24 Matches", nextOpponent: "Barcelona", nextMatchId: UUID()),
        Player(id: UUID(), name: "Antoine Griezmann", team: "Atletico Madrid", imageName: "figure.soccer", recentForm: "Assist vs Getafe", seasonStats: "12 Goals / 24 Matches", nextOpponent: "Villarreal", nextMatchId: UUID()),
        Player(id: UUID(), name: "Raphinha", team: "Barcelona", imageName: "figure.run", recentForm: "Scored in last 4", seasonStats: "17 Goals / 24 Matches", nextOpponent: "Real Madrid", nextMatchId: UUID()),
        
        // --- Serie A (Italy) ---
        Player(id: UUID(), name: "Lautaro Martinez", team: "Inter Milan", imageName: "figure.soccer", recentForm: "Brace vs Roma", seasonStats: "21 Goals / 23 Matches", nextOpponent: "Juventus", nextMatchId: UUID()),
        Player(id: UUID(), name: "Rafael Leão", team: "AC Milan", imageName: "figure.run", recentForm: "Goal & Assist vs Napoli", seasonStats: "16 Goals / 24 Matches", nextOpponent: "Lazio", nextMatchId: UUID()),
        Player(id: UUID(), name: "Khvicha Kvaratskhelia", team: "Napoli", imageName: "figure.soccer", recentForm: "Hat-trick vs Cagliari", seasonStats: "19 Goals / 23 Matches", nextOpponent: "Atalanta", nextMatchId: UUID()),
        Player(id: UUID(), name: "Dusan Vlahovic", team: "Juventus", imageName: "figure.run", recentForm: "Scored vs Torino", seasonStats: "17 Goals / 23 Matches", nextOpponent: "Inter Milan", nextMatchId: UUID()),
        Player(id: UUID(), name: "Victor Osimhen", team: "Napoli", imageName: "figure.soccer", recentForm: "Brace vs Fiorentina", seasonStats: "20 Goals / 22 Matches", nextOpponent: "Atalanta", nextMatchId: UUID()),
        Player(id: UUID(), name: "Marcus Thuram", team: "Inter Milan", imageName: "figure.run", recentForm: "Goal vs Bologna", seasonStats: "14 Goals / 24 Matches", nextOpponent: "Juventus", nextMatchId: UUID()),
        
        // --- Bundesliga (Germany) ---
        Player(id: UUID(), name: "Harry Kane", team: "Bayern Munich", imageName: "figure.soccer", recentForm: "4 goals in 2 games", seasonStats: "30 Goals / 21 Matches", nextOpponent: "Dortmund", nextMatchId: UUID()),
        Player(id: UUID(), name: "Jamal Musiala", team: "Bayern Munich", imageName: "figure.run", recentForm: "2 goals vs Leipzig", seasonStats: "15 Goals / 22 Matches", nextOpponent: "Dortmund", nextMatchId: UUID()),
        Player(id: UUID(), name: "Florian Wirtz", team: "Bayer Leverkusen", imageName: "figure.soccer", recentForm: "Hat-trick vs Stuttgart", seasonStats: "18 Goals / 22 Matches", nextOpponent: "Union Berlin", nextMatchId: UUID()),
        Player(id: UUID(), name: "Serhou Guirassy", team: "Borussia Dortmund", imageName: "figure.run", recentForm: "Brace vs Hoffenheim", seasonStats: "22 Goals / 21 Matches", nextOpponent: "Bayern Munich", nextMatchId: UUID()),
        Player(id: UUID(), name: "Victor Boniface", team: "Bayer Leverkusen", imageName: "figure.soccer", recentForm: "Scored in last 5", seasonStats: "17 Goals / 21 Matches", nextOpponent: "Union Berlin", nextMatchId: UUID()),
        Player(id: UUID(), name: "Leroy Sané", team: "Bayern Munich", imageName: "figure.run", recentForm: "Goal vs Freiburg", seasonStats: "13 Goals / 23 Matches", nextOpponent: "Dortmund", nextMatchId: UUID()),
        
        // --- Ligue 1 (France) ---
        Player(id: UUID(), name: "Bradley Barcola", team: "PSG", imageName: "figure.soccer", recentForm: "Scored in last 6", seasonStats: "19 Goals / 22 Matches", nextOpponent: "Marseille", nextMatchId: UUID()),
        Player(id: UUID(), name: "Gonçalo Ramos", team: "PSG", imageName: "figure.run", recentForm: "Hat-trick vs Lyon", seasonStats: "21 Goals / 21 Matches", nextOpponent: "Marseille", nextMatchId: UUID()),
        Player(id: UUID(), name: "Jonathan David", team: "Lille", imageName: "figure.soccer", recentForm: "Brace vs Monaco", seasonStats: "18 Goals / 23 Matches", nextOpponent: "Nice", nextMatchId: UUID()),
        Player(id: UUID(), name: "Alexandre Lacazette", team: "Lyon", imageName: "figure.run", recentForm: "Scored vs Lens", seasonStats: "16 Goals / 23 Matches", nextOpponent: "Rennes", nextMatchId: UUID()),
        Player(id: UUID(), name: "Ousmane Dembélé", team: "PSG", imageName: "figure.soccer", recentForm: "Goal & 3 Assists", seasonStats: "14 Goals / 22 Matches", nextOpponent: "Marseille", nextMatchId: UUID()),
        Player(id: UUID(), name: "Pierre-Emerick Aubameyang", team: "Marseille", imageName: "figure.run", recentForm: "Brace vs Nantes", seasonStats: "17 Goals / 23 Matches", nextOpponent: "PSG", nextMatchId: UUID())
    ]
    
    func getPlayers() -> [Player] {
        return players
    }
    
    func getFeaturedMatches() -> [Player] {
        // Return top scorers as "featured"
        return Array(players.prefix(6))
    }
    
    func getPlayer(by id: UUID) -> Player? {
        return players.first { $0.id == id }
    }
}
