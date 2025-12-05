import XCTest
@testable import mitarrito

final class AccomplishmentTests: XCTestCase {

    func testAccomplishmentInitialization() {
        let text = "Mi primer logro"
        let color = "blue"

        let accomplishment = Accomplishment(text, color: color)

        XCTAssertEqual(accomplishment.text, text)
        XCTAssertEqual(accomplishment.color, color)
        XCTAssertNotNil(accomplishment.date)
    }

    func testRandomColorInitialization() {
        let text = "Test logro"
        let accomplishment = Accomplishment(text)

        XCTAssertEqual(accomplishment.text, text)
        XCTAssertTrue(AccomplishmentColor.availableColorStrings.contains(accomplishment.color))
    }
}
