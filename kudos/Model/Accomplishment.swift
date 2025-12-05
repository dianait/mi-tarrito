import Foundation
import SwiftData

@Model
final class Accomplishment {
    var date: Date
    var text: String
    var color: String

    init(_ text: String, color: String = AccomplishmentColor.randomColorString()) {
        self.date = Date()
        self.text = text
        self.color = color
    }
}
