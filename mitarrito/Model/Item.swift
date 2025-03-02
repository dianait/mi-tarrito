import Foundation
import SwiftData

@Model
final class Item {
    var date: Date
    var text: String
    var color: String

    init(_ text: String, color: String = ColorUtility.randomColorString()) {
        self.date = Date()
        self.text = text
        self.color = color
    }
}
