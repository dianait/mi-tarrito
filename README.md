# Mi Tarrito - A Personal Achievement Tracker

Mi Tarrito is an iOS application that helps users track and celebrate their accomplishments through an engaging and accessible interface. Built with SwiftUI and SwiftData, it combines playful animations with practical functionality to make achievement tracking both fun and meaningful.

The application features a unique sticky note system for recording accomplishments, complete with confetti celebrations, a 3D carousel for reviewing past achievements, and full accessibility support. Users can write short notes (up to 140 characters) about their achievements, which are displayed with colorful sticky note animations and can be reviewed in an interactive 3D carousel view. The app supports multiple languages and includes thoughtful accessibility features like VoiceOver support and reduced motion options.

## Repository Structure
```
mitarrito/
├── mitarritoApp.swift              # Main application entry point with SwiftData configuration
├── Model/                          # Data models
│   └── Accomplishment.swift        # Core data model for achievements
├── Views/                          # UI components organized by feature
│   ├── Main/                      # Main view controllers and primary UI
│   ├── Carousel/                  # 3D carousel view for achievements
│   ├── Stickies/                  # Sticky note UI components
│   ├── AboutMe/                   # Profile and social links
│   └── Settings/                  # Application settings
├── Utilities/                      # Helper functions and constants
│   ├── Constants/                 # App-wide constant definitions
│   ├── Helpers/                   # Utility extensions and functions
│   └── Localization/             # Localization management
└── Confetti/                      # Confetti animation system
```

## Usage Instructions
### Prerequisites
- macOS Ventura 13.0 or later
- Xcode 15.0 or later
- iOS 17.0 or later for deployment
- Swift 5.9 or later

### Installation
1. Clone the repository:
```bash
git clone [repository-url]
cd mitarrito
```

2. Open the project in Xcode:
```bash
open mitarrito.xcodeproj
```

3. Select your development team in the project settings.

### Quick Start
1. Build and run the project in Xcode (⌘+R)
2. To add a new accomplishment:
```swift
// Tap the main sticky note
// Enter your achievement (up to 140 characters)
// Swipe down to save or use the accessibility action
```

### More Detailed Examples
1. Using the Carousel View:
```swift
// Swipe left/right to navigate through achievements
// Tap an achievement to view details
// Use the delete button to remove achievements
```

2. Changing Language Settings:
```swift
// Navigate to Settings
// Select preferred language
// App will update immediately
```

## Data Flow
Mi Tarrito uses SwiftData for persistent storage and manages data through a simple create-read-delete flow. Accomplishments are stored locally and displayed in both sticky note and carousel views.

```ascii
[User Input] -> [SwiftData Model] -> [UI Views]
     ↑              |                    |
     └--------------+--------------------┘
        (CRUD Operations)
```

Key Component Interactions:
1. User creates accomplishment through StickiesViewOverview
2. SwiftData stores the accomplishment with timestamp and color
3. CarouselView and StickiesView observe model changes
4. ConfettiCannon triggers celebration animations
5. LocalizationManager handles language preferences
6. Accessibility features provide VoiceOver and reduced motion support