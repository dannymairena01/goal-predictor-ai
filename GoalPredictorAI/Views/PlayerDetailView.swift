import SwiftUI

struct PlayerDetailView: View {
    @StateObject var viewModel: PlayerDetailViewModel
    
    var body: some View {
        ZStack {
            // Background
            Theme.mainBackgroundGradient
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header Profile
                    VStack(spacing: 16) {
                        ZStack {
                            // Neon Glow
                            Circle()
                                .fill(Theme.accentCyan.opacity(0.3))
                                .frame(width: 140, height: 140)
                                .blur(radius: 20)
                            
                            Image(systemName: viewModel.player.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Theme.glassGradient)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Theme.accentCyan.opacity(0.5), lineWidth: 2))
                                .shadow(color: Theme.accentCyan.opacity(0.5), radius: 10, x: 0, y: 0)
                        }
                        
                        VStack(spacing: 8) {
                            Text(viewModel.player.name)
                                .font(.appTitle)
                                .foregroundColor(Theme.textPrimary)
                                .multilineTextAlignment(.center)
                            
                            Text(viewModel.player.team)
                                .font(.title3)
                                .foregroundColor(Theme.accentCyan)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Matchup Card
                    HStack(alignment: .center, spacing: 0) {
                        VStack(spacing: 4) {
                            Text(viewModel.match.homeTeam)
                                .font(.headline)
                                .foregroundColor(Theme.textPrimary)
                                .multilineTextAlignment(.center)
                            Text("Home")
                                .font(.caption)
                                .foregroundColor(Theme.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Text("VS")
                            .font(.system(size: 28, weight: .black))
                            .italic()
                            .foregroundColor(Theme.accentPurple) // Neon Purple for VS
                            .shadow(color: Theme.accentPurple.opacity(0.8), radius: 10)
                        
                        VStack(spacing: 4) {
                            Text(viewModel.match.awayTeam)
                                .font(.headline)
                                .foregroundColor(Theme.textPrimary)
                                .multilineTextAlignment(.center)
                            Text("Away")
                                .font(.caption)
                                .foregroundColor(Theme.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(20)
                    .background(Theme.glassGradient)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Theme.cardBorder, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // Stats Grid
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Player Stats")
                            .font(.sectionHeader)
                            .foregroundColor(Theme.textPrimary)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            StatCard(title: "Season Stats", value: viewModel.player.seasonStats, icon: "chart.bar.fill", color: Theme.accentBlue)
                            StatCard(title: "Recent Form", value: viewModel.player.recentForm, icon: "waveform.path.ecg", color: Theme.accentCyan)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Prediction Section
                    if let prediction = viewModel.prediction {
                        VStack(spacing: 24) {
                            HStack {
                                Image(systemName: "sparkles")
                                    .foregroundColor(Theme.accentCyan)
                                Text("AI Analysis")
                                    .font(.sectionHeader)
                                    .foregroundColor(Theme.textPrimary)
                                Spacer()
                            }
                            
                            // Probability Ring
                            ZStack {
                                Circle()
                                    .stroke(Theme.cardBorder, lineWidth: 20)
                                    .frame(width: 180, height: 180)
                                
                                Circle()
                                    .trim(from: 0, to: prediction.probability)
                                    .stroke(
                                        LinearGradient(gradient: Gradient(colors: [Theme.accentCyan, Theme.accentBlue]), startPoint: .top, endPoint: .bottom),
                                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                                    )
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 180, height: 180)
                                    .shadow(color: Theme.accentCyan.opacity(0.5), radius: 15)
                                
                                VStack {
                                    Text("\(Int(prediction.probability * 100))%")
                                        .font(.system(size: 48, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    Text("Probability")
                                        .font(.caption)
                                        .foregroundColor(Theme.textSecondary)
                                }
                            }
                            .padding(.vertical)
                            
                            Text(prediction.reasoning)
                                .font(.body)
                                .foregroundColor(Theme.textPrimary.opacity(0.9))
                                .padding()
                                .background(Theme.accentBlue.opacity(0.1))
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Theme.accentBlue.opacity(0.3), lineWidth: 1)
                                )
                            
                            // Voting Buttons
                            HStack(spacing: 16) {
                                Button(action: { viewModel.vote(yes: true) }) {
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                        Text("Agree")
                                    }
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(viewModel.userVote == true ? LinearGradient(gradient: Gradient(colors: [Theme.success]), startPoint: .leading, endPoint: .trailing) : Theme.glassGradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Theme.cardBorder, lineWidth: 1)
                                    )
                                }
                                
                                Button(action: { viewModel.vote(yes: false) }) {
                                    HStack {
                                        Image(systemName: "hand.thumbsdown.fill")
                                        Text("Disagree")
                                    }
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(viewModel.userVote == false ? LinearGradient(gradient: Gradient(colors: [Theme.danger]), startPoint: .leading, endPoint: .trailing) : Theme.glassGradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Theme.cardBorder, lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .padding(24)
                        .background(Theme.glassGradient)
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Theme.cardBorder, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        
                    } else if viewModel.isLoading {
                        VStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Theme.accentCyan))
                                .scaleEffect(2)
                            Text("Analyzing Match Data...")
                                .font(.headline)
                                .foregroundColor(Theme.accentCyan)
                                .padding(.top, 20)
                        }
                        .frame(height: 200)
                    } else {
                        // Generate Button (Orb Style)
                        Button(action: {
                            viewModel.generatePrediction()
                        }) {
                            HStack {
                                Image(systemName: "wand.and.stars")
                                    .font(.title2)
                                Text("Generate Prediction")
                                    .font(.title3)
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Theme.accentGradient)
                            .cornerRadius(20)
                            .shadow(color: Theme.accentBlue.opacity(0.5), radius: 20, x: 0, y: 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(Theme.danger)
                            .font(.caption)
                            .padding()
                    }
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .background(Theme.mainBackgroundGradient.edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title2)
                .padding(10)
                .background(color.opacity(0.2))
                .clipShape(Circle())
            
            Text(value)
                .font(.headline)
                .foregroundColor(Theme.textPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(title)
                .font(.caption)
                .foregroundColor(Theme.textSecondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.glassGradient)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
}
