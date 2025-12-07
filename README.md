# 🎉 Kudos

An iOS app to save and celebrate your personal achievements. A digital space where you can record your victories and watch your collection grow with each achievement reached.

> **Español** | [English](#-kudos)

## 📱 Description

Kudos is an application that allows you to save your achievements as digital sticky notes. Every time you save an achievement, your collection grows and you can celebrate it with confetti animations. The app is designed with a focus on privacy: all your data remains exclusively on your device.

## ✨ Features

- **Save achievements**: Create sticky notes with your achievements and personal victories
- **Visual counter**: See how many achievements you've saved in your collection
- **Celebration animations**: Animated confetti when you save a new achievement
- **Achievement carousel**: Navigate through all your saved achievements with a swipe gesture
- **Multi-language**: Support for Spanish and English with real-time language switching
- **Complete privacy**: All data is stored locally on your device
- **Accessibility**: Full VoiceOver and accessibility implementation
- **Intuitive interface**: Modern and easy-to-use design

## 🚀 Getting Started

1. Download the app from the App Store (when available)
2. Open the app on your iOS device
3. Start saving your achievements!

## 📖 How to Use

1. **Add an achievement**:

   - Tap the yellow note on the main screen
   - Write your achievement in the text editor
   - Swipe up to save

2. **View your achievements**:

   - Tap the counter at the top to see all your saved achievements
   - Swipe horizontally to navigate between them

3. **Change language**:

   - Tap the "Settings" button at the bottom
   - Select your preferred language

4. **Delete achievements**:
   - In the carousel view, tap the delete button on any note

## 🎨 Design Features

- **Sticky notes**: Each achievement is saved as a note with a random color (orange, yellow, green, blue)
- **Responsive design**: Adapts to different screen sizes
- **Smooth animations**: Fluid transitions between views
- **Light theme**: Clean and modern interface with white background

## 🔒 Privacy

Kudos is committed to your privacy:

- All data is stored locally on your device
- No personal information is collected
- No connection to external servers
- Your achievements never leave your phone

## 📚 Project History

The idea for Kudos was born at LicorcaConf during a talk about Impostor Syndrome. Silvia shared that she had a physical folder where she kept the good things that happened to her at work. Inspired by this idea, a physical jar was created that was filled with notes about personal achievements.

The concept was shared on Twitter and gained popularity, being mentioned at events like AntiEvent, TechFest, and Software Crafters in Barcelona. This app is the digital version of that physical jar, allowing everyone to have their own space to celebrate their achievements.

## 🏗️ Architecture

### Project Structure

```
kudos/
├── Model/                    # Data models (SwiftData)
│   └── Accomplishment.swift
├── Views/                    # SwiftUI views organized by feature
│   ├── Main/                 # Main screen views
│   ├── Carousel/             # Achievement carousel
│   ├── Stickies/             # Sticky note components
│   ├── Settings/             # Settings views
│   ├── AboutMe/              # About section
│   └── Error/                # Error handling views
├── Utilities/
│   ├── Constants/            # App constants (sizes, spacing, timing, etc.)
│   ├── Helpers/              # Helper extensions and utilities
│   ├── Localization/         # Localization system (ES/EN)
│   └── Validation/           # Data validation logic
└── Confetti/                 # Confetti animation components
```

### Key Design Patterns

- **MVVM**: ViewModels for state management (e.g., `MainViewModel`)
- **SwiftData**: Local persistence with `@Model` and `@Query`
- **Dependency Injection**: Environment objects for shared state
- **Validation Layer**: Centralized validation before data persistence
- **Accessibility First**: Full VoiceOver support with localized labels

### Technical Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Persistence**: SwiftData
- **Minimum iOS**: iOS 17.0+
- **Architecture**: MVVM with SwiftUI

## 🔧 Development

### Requirements

- Xcode 15.0+
- iOS 17.0+ deployment target
- Swift 5.9+

### Building the Project

1. Open `kudos.xcodeproj` in Xcode
2. Select your target device or simulator
3. Build and run (⌘R)

### Testing

The project includes:

- **Unit Tests**: Model validation, utilities, and business logic
- **UI Tests**: End-to-end user flows
- **Accessibility Tests**: VoiceOver and accessibility features

Run tests with ⌘U in Xcode.

## 📝 Code Quality

### Best Practices

- **Constants**: All magic numbers extracted to `Constants/` directory
- **Validation**: Data validation at multiple layers (model, view, viewmodel)
- **Localization**: All user-facing strings are localized (ES/EN)
- **Accessibility**: Full VoiceOver support with descriptive labels and hints
- **Error Handling**: Graceful error handling with user-friendly messages
- **Performance**: Optimized rendering (lazy loading, view recycling in carousel)

### Code Style

- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Keep views small and focused
- Extract reusable components
- Document complex logic with comments

## ♿ Accessibility

Kudos is designed with accessibility in mind:

- **VoiceOver**: Full support with descriptive labels and hints
- **Dynamic Type**: Supports all system font sizes
- **Reduce Motion**: Respects user's motion preferences
- **Reduce Transparency**: Adapts to user's transparency preferences
- **High Contrast**: Works with high contrast modes
- **Keyboard Navigation**: Full keyboard support where applicable

All accessibility strings are localized and tested with VoiceOver.

## 🧪 Testing Strategy

### Unit Tests

- Model validation
- Utility functions
- ViewModels logic
- Color and formatting helpers

### UI Tests

- User flows (add, view, delete achievements)
- Navigation between screens
- Language switching

### Accessibility Tests

- VoiceOver navigation
- Accessibility labels and hints
- Dynamic Type support

## 📚 Additional Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [SwiftData Documentation](https://developer.apple.com/documentation/swiftdata)
- [Accessibility Guidelines](https://developer.apple.com/accessibility/ios/)

## 👤 Author

Developed with ❤️ by [@Dianait](https://linkedin/in/dianait)

---

Celebrate your achievements and grow your collection of kudos! 🎉
