import SwiftUI
import UIKit

struct ContentView: View {
    init() {
        // Custom Tab Bar Appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Theme.backgroundStart.opacity(0.9)) // Dark Blue background
        
        // Unselected Item Color
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        // Selected Item Color
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Theme.accentCyan) // Cyan
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Theme.accentCyan)]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "sportscourt.fill")
                }
            
            MyPredictionsView()
                .tabItem {
                    Label("My Predictions", systemImage: "list.clipboard.fill")
                }
        }
        .accentColor(Theme.accentCyan) // Use Cyan for selection
        .preferredColorScheme(.dark)
    }
}
