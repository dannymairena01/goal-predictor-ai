import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    // Custom initializer to set navigation bar appearance appearance
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                Theme.mainBackgroundGradient
                    .ignoresSafeArea()
                
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Goal Predictor AI")
                                .font(.appTitle)
                                .foregroundColor(Theme.textPrimary)
                                .shadow(color: Theme.accentCyan.opacity(0.5), radius: 10, x: 0, y: 0) // Neon Glow
                            
                            Text("Matchday Intuition")
                                .font(.subheadline)
                                .foregroundColor(Theme.textSecondary)
                                .tracking(1) // Space out letters slightly
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        // Glass Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Theme.textSecondary)
                            
                            TextField("Search player...", text: $viewModel.searchText)
                                .foregroundColor(Theme.textPrimary)
                                // Placeholder color hack
                                .accentColor(Theme.accentCyan)
                                .onSubmit {
                                    Task { await viewModel.performSearch() }
                                }
                            
                            // Explicit Search Button
                            Button(action: {
                                Task { await viewModel.performSearch() }
                            }) {
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundColor(Theme.accentCyan)
                                    .font(.title2)
                                    .shadow(color: Theme.accentCyan.opacity(0.6), radius: 5)
                            }
                        }
                        .padding()
                        .background(Theme.glassGradient)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Theme.cardBorder, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        
                        // Loading State
                        if viewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Theme.accentCyan))
                                    .scaleEffect(1.2)
                                Spacer()
                            }
                            .padding()
                        }
                        
                        // Error State
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(Theme.danger)
                                .font(.caption)
                                .padding(.horizontal)
                        }
                        
                        // Featured Section (Horizontal Scroll)
                        if viewModel.searchText.isEmpty {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("Featured Matches")
                                        .font(.sectionHeader)
                                        .foregroundColor(Theme.textPrimary)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(viewModel.featuredPlayers) { player in
                                            NavigationLink(destination: PlayerDetailView(viewModel: PlayerDetailViewModel(player: player))) {
                                                FeaturedPlayerCard(player: player)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom, 20) // Shadow space
                                }
                            }
                        }
                        
                        // Trending / List Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text(viewModel.searchText.isEmpty ? "Trending Players" : "Search Results")
                                .font(.sectionHeader)
                                .foregroundColor(Theme.textPrimary)
                                .padding(.horizontal)
                            
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.filteredPlayers) { player in
                                    NavigationLink(destination: PlayerDetailView(viewModel: PlayerDetailViewModel(player: player))) {
                                        PlayerRow(player: player)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Subviews

struct FeaturedPlayerCard: View {
    let player: Player
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                // Image Background
                Theme.glassGradient
                    .frame(height: 150)
                
                // Neon Glow Circle behind player
                Circle()
                    .fill(Theme.accentCyan.opacity(0.3))
                    .frame(width: 100, height: 100)
                    .blur(radius: 20)
                    .offset(x: -20, y: 20)
                
                Image(systemName: player.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.white)
                    .shadow(color: .white.opacity(0.3), radius: 5)
                    .padding()
                
                // Team Badge
                Text(player.team)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Theme.accentBlue.opacity(0.8)))
                    .overlay(Capsule().stroke(Color.white.opacity(0.3), lineWidth: 1))
                    .foregroundColor(.white)
                    .padding(10)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(player.name)
                    .font(.headline)
                    .foregroundColor(Theme.textPrimary)
                    .lineLimit(1)
                
                HStack {
                    Text("vs \(player.nextOpponent)")
                        .font(.caption)
                        .foregroundColor(Theme.accentCyan)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(Theme.textSecondary)
                }
            }
            .padding(16)
            .background(Theme.glassGradient)
        }
        .frame(width: 200)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
        // Neon Shadow
        .shadow(color: Theme.accentBlue.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

struct PlayerRow: View {
    let player: Player
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            ZStack {
                Circle()
                    .fill(Theme.glassGradient)
                    .frame(width: 50, height: 50)
                    .overlay(Circle().stroke(Theme.cardBorder, lineWidth: 1))
                
                Image(systemName: player.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.headline)
                    .foregroundColor(Theme.textPrimary)
                
                Text(player.team)
                    .font(.caption)
                    .foregroundColor(Theme.textSecondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("vs \(player.nextOpponent)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Theme.accentCyan)
                
                Text(player.recentForm.prefix(15) + "...")
                    .font(.caption2)
                    .foregroundColor(Theme.textSecondary)
            }
            
            Image(systemName: "chevron.right")
                .foregroundColor(Theme.textSecondary.opacity(0.5))
                .font(.caption)
        }
        .padding()
        .background(Theme.glassGradient)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
}
