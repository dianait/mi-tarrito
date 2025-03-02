import SwiftUI

extension Color {
    static func fromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
            case "soft-blue":
                return Color(red: 0.7, green: 0.85, blue: 0.95)
            case "soft-green":
                return Color(red: 0.75, green: 0.92, blue: 0.75)
            case "soft-purple":
                return Color(red: 0.85, green: 0.80, blue: 0.95)
            case "soft-pink":
                return Color(red: 0.95, green: 0.85, blue: 0.90)
            case "soft-orange":
                return Color(red: 1.0, green: 0.90, blue: 0.75)
            case "soft-teal":
                return Color(red: 0.75, green: 0.90, blue: 0.90)
            case "soft-yellow":
                return Color(red: 1.0, green: 0.90, blue: 0.60) 
            default:
                return Color(red: 0.85, green: 0.85, blue: 0.85) // Soft gray
        }
    }
}

func colorForIndex(_ index: Int) -> Color {
    let softColors: [Color] = [
        Color(red: 0.7, green: 0.85, blue: 0.95),   // Soft Blue
        Color(red: 0.75, green: 0.92, blue: 0.75),  // Soft Green
        Color(red: 0.85, green: 0.80, blue: 0.95), // Soft Purple
        Color(red: 0.95, green: 0.90, blue: 0.75), // Soft Orange
        Color(red: 0.75, green: 0.90, blue: 0.90)  // Soft Teal
    ]
    return softColors[index % max(softColors.count, 1)]
}

struct ColorUtility {
    static let availableColors = [
        "soft-blue",
        "soft-green",
        "soft-purple",
        "soft-pink",
        "soft-orange",
        "soft-teal",
        "soft-yellow"
    ]

    static func randomColorString() -> String {
        return availableColors.randomElement() ?? "soft-gray"
    }
}
