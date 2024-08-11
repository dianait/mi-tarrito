import SwiftUI

extension Color {
    static func fromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
            case "black":
                return .black
            case "blue":
                return .blue
            case "brown":
                return .brown
            case "clear":
                return .clear
            case "cyan":
                return .cyan
            case "gray":
                return .gray
            case "green":
                return .green
            case "indigo":
                return .indigo
            case "mint":
                return .mint
            case "orange":
                return .orange
            case "pink":
                return .pink
            case "purple":
                return .purple
            case "red":
                return .red
            case "teal":
                return .teal
            case "white":
                return .white
            case "yellow":
                return .yellow
            default:
                return .gray
        }
    }
}
