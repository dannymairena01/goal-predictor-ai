import Foundation

class StorageService {
    static let shared = StorageService()
    
    private let favoritesKey = "saved_predictions"
    private let votesKey = "user_votes"
    
    // Simple persistence using UserDefaults for MVP
    
    func savePrediction(_ prediction: Prediction) {
        var saved = getSavedPredictions()
        if !saved.contains(where: { $0.id == prediction.id }) {
            saved.append(prediction)
            if let encoded = try? JSONEncoder().encode(saved) {
                UserDefaults.standard.set(encoded, forKey: favoritesKey)
            }
        }
    }
    
    func getSavedPredictions() -> [Prediction] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let predictions = try? JSONDecoder().decode([Prediction].self, from: data) else {
            return []
        }
        return predictions
    }
    
    // User Vote: true = Yes, false = No
    func saveVote(for predictionId: UUID, vote: Bool) {
        var votes = getUserVotes()
        votes[predictionId.uuidString] = vote
        UserDefaults.standard.set(votes, forKey: votesKey)
        
        // In a real app, send this to a backend for community stats
    }
    
    func getUserVotes() -> [String: Bool] {
        return UserDefaults.standard.dictionary(forKey: votesKey) as? [String: Bool] ?? [:]
    }
    
    func getStats() -> (total: Int, correct: Int) {
        // Since we can't easily verify "real" outcomes in this MVP without a live score API,
        // we'll mock the 'correctness' verification or leave it as a placeholder.
        // For MVP, we can just return the count of predictions made.
        let predictions = getSavedPredictions()
        return (predictions.count, Int(Double(predictions.count) * 0.65)) // Mock accuracy
    }
}
