import Foundation
import Combine

@MainActor
class PlayerDetailViewModel: ObservableObject {
    @Published var prediction: Prediction?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var userVote: Bool?
    
    let player: Player
    let match: Match // Should be passed or fetched based on player
    
    private let openAIService = OpenAIService.shared
    private let storageService = StorageService.shared
    
    init(player: Player) {
        self.player = player
        // Mock a next match for MVP
        self.match = Match(
            id: UUID(),
            homeTeam: player.team,
            awayTeam: player.nextOpponent,
            date: Date().addingTimeInterval(86400 * Double.random(in: 1...5)), // 1-5 days later
            venue: "Home Stadium"
        )
        
        checkExistingVote()
    }
    
    func generatePrediction() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let result = try await openAIService.generatePrediction(for: player, match: match)
                self.prediction = result
                storageService.savePrediction(result)
            } catch {
                self.errorMessage = "Failed to get prediction: \(error.localizedDescription)"
            }
            self.isLoading = false
        }
    }
    
    func vote(yes: Bool) {
        guard let prediction = prediction else { return }
        userVote = yes
        storageService.saveVote(for: prediction.id, vote: yes)
    }
    
    private func checkExistingVote() {
        // Check if we already have a prediction/vote for this match context (Mock implementation)
    }
}
