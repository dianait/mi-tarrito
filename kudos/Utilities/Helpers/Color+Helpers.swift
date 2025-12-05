import SwiftUI

// MARK: - Accomplishment Color System
/// Enum that defines all available colors for accomplishments with their RGB values
enum AccomplishmentColor: String, CaseIterable {
    case blue
    case green
    case purple
    case pink
    case orange
    case teal
    case yellow
    
    /// RGB values for each color (0.0 - 1.0 range)
    /// Colors are balanced - not too soft, not too strong, consistent with the app icon palette
    var rgbValues: (red: Double, green: Double, blue: Double) {
        switch self {
        case .blue:
            return (0.65, 0.80, 0.90) // Medium blue
        case .green:
            return (0.70, 0.88, 0.75) // Medium mint green
        case .purple:
            return (0.80, 0.70, 0.88) // Medium purple, works better with stickers
        case .pink:
            return (0.92, 0.80, 0.88) // Medium rose pink
        case .orange:
            return (0.95, 0.82, 0.70) // Medium peach orange, consistent with icon notes
        case .teal:
            return (0.70, 0.85, 0.85) // Medium aqua teal
        case .yellow:
            return (0.96, 0.88, 0.65) // Medium golden yellow, consistent with icon stars
        }
    }
    
    /// SwiftUI Color representation
    var color: Color {
        let rgb = rgbValues
        return Color(red: rgb.red, green: rgb.green, blue: rgb.blue)
    }
    
    /// Array of all color names as strings
    static var availableColorStrings: [String] {
        return AccomplishmentColor.allCases.map { $0.rawValue }
    }
    
    /// Returns a random color string
    static func randomColorString() -> String {
        return allCases.randomElement()?.rawValue ?? "gray"
    }
}

// MARK: - Color Extension
extension Color {
    /// Converts a color string to a SwiftUI Color
    /// - Parameter colorString: The color name as a string
    /// - Returns: A SwiftUI Color, or a default gray if the string doesn't match
    static func fromString(_ colorString: String) -> Color {
        guard let accomplishmentColor = AccomplishmentColor(rawValue: colorString.lowercased()) else {
            // Return soft gray as default
            return Color(red: 0.85, green: 0.85, blue: 0.85)
        }
        return accomplishmentColor.color
    }
}

