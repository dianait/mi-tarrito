import SwiftUI

extension Color {
    static func fromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
            case "blue":
                return Color(red: 0.7, green: 0.85, blue: 0.95)
            case "green":
                return Color(red: 0.75, green: 0.92, blue: 0.75)
            case "purple":
                return Color(red: 0.85, green: 0.80, blue: 0.95)
            case "pink":
                return Color(red: 0.95, green: 0.85, blue: 0.90)
            case "orange":
                return Color(red: 1.0, green: 0.90, blue: 0.75)
            case "teal":
                return Color(red: 0.75, green: 0.90, blue: 0.90)
            case "yellow":
                return Color(red: 1.0, green: 0.90, blue: 0.60) 
            default:
                return Color(red: 0.85, green: 0.85, blue: 0.85) // Soft gray
        }
    }
}

func colorForIndex(_ index: Int) -> Color {
    let softColors: [Color] = [
        Color(red: 0.7, green: 0.85, blue: 0.95),   // Blue
        Color(red: 0.75, green: 0.92, blue: 0.75),  // Green
        Color(red: 0.85, green: 0.80, blue: 0.95), // Purple
        Color(red: 0.95, green: 0.90, blue: 0.75), // Orange
        Color(red: 0.75, green: 0.90, blue: 0.90)  // Teal
    ]
    return softColors[index % max(softColors.count, 1)]
}

struct ColorUtility {
    static let availableColors = [
        "blue",
        "green",
        "purple",
        "pink",
        "orange",
        "teal",
        "yellow"
    ]

    static func randomColorString() -> String {
        return availableColors.randomElement() ?? "gray"
    }
}
