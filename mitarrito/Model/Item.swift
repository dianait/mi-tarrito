import Foundation
import SwiftData

@Model
final class Item: Equatable {
    var date: Date
    var text: String
    var color: String

    init(text: String, color: String) {
        self.date = Date()
        self.text = text
        self.color = color
    }
}
