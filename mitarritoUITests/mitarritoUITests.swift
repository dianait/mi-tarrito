import XCTest
@testable import mitarrito

final class MiTarritoUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddNewAccomplishment() throws {
        throw XCTSkip("WIP")
        let stickyNote = app.otherElements["logro-editor"]
        XCTAssert(stickyNote.exists)
        stickyNote.tap()

        let textEditor = app.textViews.matching(identifier: "logro-editor").firstMatch
        XCTAssertTrue(textEditor.exists)
        textEditor.tap()
        textEditor.typeText("Mi logro de test automatizado")

        textEditor.swipeUp()

        let confirmationText = app.staticTexts["¡Logro guardado!"]
        XCTAssertTrue(confirmationText.waitForExistence(timeout: 2))
    }

    func testViewAccomplishmentsInTarrito() throws {
        throw XCTSkip("WIP")
        try testAddNewAccomplishment()

        let tarritoButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'Tarrito con'")).firstMatch
        XCTAssertTrue(tarritoButton.exists)
        tarritoButton.tap()

        let accomplishmentText = app.staticTexts["Mi logro de test automatizado"]
        XCTAssertTrue(accomplishmentText.waitForExistence(timeout: 2))
    }

    func testNavigateToAboutView() {
        let aboutButton = app.buttons["About me Button-About me Button"]
        // TODO: Check this identifier issue
        XCTAssert(aboutButton.exists)
        aboutButton.tap()

        let aboutTitle = app.staticTexts["About me Title"]
        XCTAssertTrue(aboutTitle.waitForExistence(timeout: 2))
    }
}
