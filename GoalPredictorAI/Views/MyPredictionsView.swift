import SwiftUI

struct MyPredictionsView: View {
    @State private var predictions: [Prediction] = []
    
    // Custom init for transparent List
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Theme.mainBackgroundGradient
                    .ignoresSafeArea()
                
                if predictions.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "list.clipboard")
                            .font(.system(size: 60))
                            .foregroundColor(Theme.textSecondary.opacity(0.3))
                        Text("No predictions yet")
                            .font(.title3)
                            .foregroundColor(Theme.textSecondary)
                        Text("Go to the Home tab to start predicting!")
                            .font(.subheadline)
                            .foregroundColor(Theme.textSecondary.opacity(0.7))
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            // Stats Header
                            HStack(spacing: 16) {
                                StatBox(title: "Total", value: "\(predictions.count)", color: Theme.accentBlue)
                                StatBox(title: "Accuracy", value: "65%", color: Theme.success) // Mock accuracy
                            }
                            .padding(.horizontal)
                            
                            // Predictions List
                            VStack(alignment: .leading, spacing: 16) {
                                Text("History")
                                    .font(.sectionHeader)
                                    .foregroundColor(Theme.textPrimary)
                                    .padding(.horizontal)
                                
                                LazyVStack(spacing: 12) {
                                    ForEach(predictions) { prediction in
                                        PredictionRow(prediction: prediction)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Predictions")
                        .font(.headline)
                        .foregroundColor(Theme.textPrimary)
                }
            }
            .onAppear {
                predictions = StorageService.shared.getSavedPredictions()
            }
        }
    }
}

// MARK: - Subviews

struct StatBox: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.appTitle)
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .foregroundColor(Theme.textSecondary)
                .textCase(.uppercase)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Theme.glassGradient)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
}

struct PredictionRow: View {
    let prediction: Prediction
    var player: Player? {
        DataService.shared.getPlayer(by: prediction.playerId) // Corrected property name
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(Theme.glassGradient)
                    .frame(width: 44, height: 44)
                
                Image(systemName: player?.imageName ?? "person.fill")
                    .foregroundColor(Theme.textPrimary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let player = player {
                    Text(player.name)
                        .font(.headline)
                        .foregroundColor(Theme.textPrimary)
                } else {
                    Text("Unknown Player")
                        .font(.headline)
                        .foregroundColor(Theme.danger)
                }
                
                Text(prediction.reasoning)
                    .font(.caption)
                    .foregroundColor(Theme.textSecondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Probability Badge
            VStack {
                Text("\(Int(prediction.probability * 100))%")
                    .font(.headline)
                    .foregroundColor(prediction.probability > 0.6 ? Theme.success : Theme.danger)
                
                Text("Prob")
                    .font(.caption2)
                    .foregroundColor(Theme.textSecondary)
            }
            .padding(8)
            .background(Theme.cardBackground)
            .cornerRadius(8)
        }
        .padding()
        .background(Theme.glassGradient)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
}
