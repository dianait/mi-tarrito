import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var text: String

    init(timestamp: Date, text: String = "This is a example message") {
        self.timestamp = timestamp
        self.text = text
    }
}
