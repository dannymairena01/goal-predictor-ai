# Goal Predictor AI ⚽️🤖

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

**Goal Predictor AI** is a premium iOS application that leverages **OpenAI's GPT-4o** to analyze soccer player performance and predict whether they will score in their next match. Built with **SwiftUI**, it features a futuristic "Dark Glass" aesthetic, real-time-style analytics, and comprehensive player tracking.

## ✨ Key Features

-   **🔮 AI-Powered Analysis**: Generates detailed predictions with confidence scores and reasoning using GPT-4o.
-   **🎨 Futuristic UI**: Premium dark mode design with glassmorphism, neon accents, and fluid animations.
-   **📊 Player Stats**: View season stats (Goals, Assists, xG) and recent form for top players.
-   **🗳️ User Voting**: Agree or disagree with AI predictions and track your own accuracy.
-   **💾 Local History**: All predictions are saved locally for future reference.

## 📱 Screenshots

*(Add your screenshots here)*

## 🚀 Getting Started

### Prerequisites

-   Xcode 15.0+
-   iOS 17.0+
-   An OpenAI API Key (for new predictions)

### Installation

1.  **Clone the repo**:
    ```bash
    git clone https://github.com/dannymairena01/goal-predictor-ai.git
    cd goal-predictor-ai
    ```

2.  **Open in Xcode**:
    Double-click `GoalPredictorAI.xcodeproj`.

3.  **Add your API Key**:
    -   Navigate to `GoalPredictorAI/Services/OpenAIService.swift`.
    -   Find the `apiKey` property.
    -   Replace `"YOUR_OPENAI_API_KEY"` with your valid key.
    
    > **Note**: The API key is required only for generation *new* predictions. The app comes pre-loaded with mock data for testing the UI.

4.  **Run the App**:
    Select your target simulator (e.g., iPhone 15 Pro) and press `Cmd+R`.

## 🛠 Tech Stack

-   **Language**: Swift 5.9
-   **UI Framework**: SwiftUI
-   **Architecture**: MVVM (Model-View-ViewModel)
-   **AI Model**: OpenAI GPT-4o
-   **Persistence**: UserDefaults
-   **Networking**: URLSession, async/await

## 📂 Project Structure

-   `Extensions/Theme.swift`: Centralized design system (Colors, Fonts, Gradients).
-   `Services/`: Handles API calls (`OpenAIService`) and data management (`DataService`, `StorageService`).
-   `ViewModels/`: Business logic for Home, Detail, and Prediction views.
-   `Views/`: SwiftUI views including `HomeView`, `PlayerDetailView`, and `MyPredictionsView`.

## 🚧 Known Limitations (v1.0)

-   **Mock Data**: Player data and match schedules are currently hardcoded for demonstration. Live API integration (TheSportsDB) is planned for v1.1.
-   **Auth**: No user accounts; data is stored locally on the device.

## 🔜 Roadmap

-   [ ] Integrate TheSportsDB API for live match data.
-   [ ] Add user authentication (Firebase/Apple Sign-In).
-   [ ] Implement push notifications for match results.
-   [ ] Social sharing for predictions.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Built with ❤️ by [Danny Mairena](https://github.com/dannymairena01)
