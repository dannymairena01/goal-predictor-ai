import SwiftUI

struct Theme {
    // MARK: - Futuristic Palette
    // Deep Midnight Blue (0F172A)
    static let backgroundStart = Color(red: 15/255, green: 23/255, blue: 42/255)
    // Dark Indigo (1E1B4B)
    static let backgroundEnd = Color(red: 30/255, green: 27/255, blue: 75/255)
    
    static let cardBackground = Color.white.opacity(0.1)
    static let cardBorder = Color.white.opacity(0.2)
    
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.7)
    
    // Electric Cyan (06B6D4)
    static let accentCyan = Color(red: 6/255, green: 182/255, blue: 212/255)
    // Bright Blue (3B82F6)
    static let accentBlue = Color(red: 59/255, green: 130/255, blue: 246/255)
    // Neon Purple (8B5CF6)
    static let accentPurple = Color(red: 139/255, green: 92/255, blue: 246/255)
    
    // Emerald Green (10B981)
    static let success = Color(red: 16/255, green: 185/255, blue: 129/255)
    // Bright Red (EF4444)
    static let danger = Color(red: 239/255, green: 68/255, blue: 68/255)
    
    // MARK: - Gradients
    static let mainBackgroundGradient = LinearGradient(
        gradient: Gradient(colors: [backgroundStart, backgroundEnd]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accentGradient = LinearGradient(
        gradient: Gradient(colors: [accentCyan, accentBlue]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let glassGradient = LinearGradient(
        gradient: Gradient(colors: [Color.white.opacity(0.15), Color.white.opacity(0.05)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension Font {
    static let appTitle = Font.system(size: 32, weight: .bold, design: .rounded)
    static let sectionHeader = Font.system(size: 22, weight: .bold, design: .default)
    static let cardTitle = Font.system(size: 18, weight: .semibold, design: .default)
    static let statNumber = Font.system(size: 36, weight: .light, design: .default)
}
