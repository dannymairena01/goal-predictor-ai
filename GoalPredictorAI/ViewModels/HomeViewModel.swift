import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var players: [Player] = [] // This holds ALL players
    @Published var searchText: String = ""
    @Published var featuredPlayers: [Player] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let dataService = DataService.shared
    private let apiService = APIService.shared
    
    init() {
        // Load Mock Data initially so the screen isn't empty
        self.players = dataService.getPlayers()
        self.featuredPlayers = dataService.getFeaturedMatches()
    }
    
    var filteredPlayers: [Player] {
        // If searching, we show the search results (which might be from API)
        // If empty, we show the mock list
        return players
    }
    
    @MainActor
    func performSearch() async {
        guard !searchText.isEmpty else {
            self.players = dataService.getPlayers() // Reset to mock data if empty
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        self.players = [] // Clear old data/mock data immediately so user knows search is happening
        
        do {
            // 🌍 CALLING LIVE API
            let livePlayers = try await apiService.searchPlayer(name: searchText)
            self.players = livePlayers
        } catch {
            self.errorMessage = "Could not find player: \(error.localizedDescription)"
            print("Search error: \(error)")
        }
        
        self.isLoading = false
    }
}
