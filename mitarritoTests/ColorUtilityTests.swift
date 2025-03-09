import XCTest
import SwiftUI
@testable import mitarrito

final class ColorUtilityTests: XCTestCase {

    func testRandomColorString() {
        let randomColor = ColorUtility.randomColorString()
        XCTAssertTrue(ColorUtility.availableColors.contains(randomColor))
    }

    func testColorFromString() {
        let blueColor = Color.fromString("blue")
        let greenColor = Color.fromString("green")
        let defaultColor = Color.fromString("nonexistent")

        XCTAssertNotNil(blueColor)
        XCTAssertNotNil(greenColor)
        XCTAssertNotNil(defaultColor)
    }
}
