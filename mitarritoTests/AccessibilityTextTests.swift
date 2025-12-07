import XCTest
@testable import kudos

final class AccessibilityTextTests: XCTestCase {

    func testTarritoLabel() {
        XCTAssertEqual(A11y.Tarrito.label(count: 1), "Tarrito con 1 logro guardado")
        XCTAssertEqual(A11y.Tarrito.label(count: 2), "Tarrito con 2 logros guardados")
    }

    func testStickiesViewLabel() {
        XCTAssertEqual(A11y.StickiesView.label(lastMessage: ""), "Escribe aquí...")
        XCTAssertEqual(A11y.StickiesView.label(lastMessage: "Hola"), "Hola")
    }
}
