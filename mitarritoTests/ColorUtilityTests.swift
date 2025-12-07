import XCTest
import SwiftUI
@testable import kudos

final class AccomplishmentColorTests: XCTestCase {

    func testRandomColorString() {
        let randomColor = AccomplishmentColor.randomColorString()
        XCTAssertTrue(AccomplishmentColor.availableColorStrings.contains(randomColor))
    }

    func testColorFromString() {
        let blueColor = Color.fromString("blue")
        let greenColor = Color.fromString("green")
        let defaultColor = Color.fromString("nonexistent")

        XCTAssertNotNil(blueColor)
        XCTAssertNotNil(greenColor)
        XCTAssertNotNil(defaultColor)
    }
    
    func testAccomplishmentColorEnum() {
        // Test that all cases are accessible
        XCTAssertEqual(AccomplishmentColor.allCases.count, 7)
        
        // Test that each color has valid RGB values
        for colorCase in AccomplishmentColor.allCases {
            let rgb = colorCase.rgbValues
            XCTAssertGreaterThanOrEqual(rgb.red, 0.0)
            XCTAssertLessThanOrEqual(rgb.red, 1.0)
            XCTAssertGreaterThanOrEqual(rgb.green, 0.0)
            XCTAssertLessThanOrEqual(rgb.green, 1.0)
            XCTAssertGreaterThanOrEqual(rgb.blue, 0.0)
            XCTAssertLessThanOrEqual(rgb.blue, 1.0)
            
            // Test that color property works
            let color = colorCase.color
            XCTAssertNotNil(color)
        }
    }
}
