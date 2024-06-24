# LocalTennis

LocalTennis is a mobile app developed in Swift for iOS, utilizing SwiftUI. It allows you to simulate tennis matches point by point, manage matches and players, and view live match updates on your lock screen and dynamic island via live activities.

## Motivation

As a tennis fan, to develop something like LocalTennis was the perfect oportunity to explore and play with some of Apple's native frameworks and APIs to develop mobile apps. In particular, the technologies used in LocalTennis are:

- **Swift**: main programming language.
- **SwiftUI**: to declare the UI and manage views, navigation and behavior.
- **Foundation**:
  - **UserDefaults**: to store and persist the user preferences (settings).
  - **File System**: to persist the matches and players data.
- **WidgetKit**: to declare and configure the live activities UI and presentations.
- **ActivityKit**: to manage the life cycle of live activities.

## Main Features

- Simulate tennis matches, point by point.
- Display the status of the match as it's played inside the app.
- View and manage the matches played.
- View and manage the players that participate in matches.
- Display the status of the match as it's played in a live activity (lock screen and dynamic island).

### Ideas for future features

- Add coin toss before the match begins to determine which player serve first.
- Add action buttons to the live activities to control the current match from them (requires using the App Intents API).
- Personalize the app's UI components to give it a unique identity.
- Develop a companion WatchOS app to view and control the current match from the wrist.

## Requirements

- Xcode 15.0 or later
- iOS 17.0 or later

## Environment Setup

To set up your development environment for LocalTennis, follow these steps:

1. **Install Xcode:**
   - Download and install Xcode from the Mac App Store or the [Apple Developer website](https://developer.apple.com/xcode/).
2. **Clone the Repository**
3. **Open the Project:**
   - Open `LocalTennis.xcodeproj` in Xcode.
4. **Build and Run:**
   - Select your target device and press the `Run` button in Xcode.

## Screenshots

| **List of matches** | **Actions of a match** | **New match form** |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ![List of matches](/docs/screenshots/1.history.png "List of matches") | ![Actions of a match](/docs/screenshots/2.history-actions.png "Actions of a match") | ![New match form](/docs/screenshots/3.new-match.png "New match form") |
| **Match view** | **Players list** | **Actions of a player** |
| ![Match view](/docs/screenshots/4.match.png "Match view") | ![Players list](/docs/screenshots/5.players.png "Players list") | ![Actions of a player](/docs/screenshots/6.players-actions.png "Shoe details") |
| **New player form** | **Settings** | **Live activity (lock screen)** |
| ![New player form](/docs/screenshots/7.new-player.png "New player form") | ![Settings](/docs/screenshots/8.settings.png "Settings") | ![Live activity (lockscreen)](/docs/screenshots/9.live-activity-lockscreen.png) |
| **Live activity (dynamic island)** | **Live activity (dynamic island expanded)** ||
| ![Live activity (dynamic island)](/docs/screenshots/10.live-activity-dynamic-island.png "Live activity (dynamic island)") | ![Live activity (dynamic island expanded)](/docs/screenshots/11.live-activity-dynamic-island-expanded.png "Live activity (dynamic island expanded)") ||
