import XCTest
@testable import kudos

final class ViewComponentTests: XCTestCase {

    @MainActor
    func testDateLabelView() throws {
        let date = Date()
        let view = DateLabelView(date: date)

        let _ = try XCTUnwrap(view.body)
    }

    @MainActor
    func testDeleteButtonView() throws {
        var buttonPressed = false
        let view = DeleteButtonView(action: { buttonPressed = true })

        let _ = try XCTUnwrap(view.body)
    }

    @MainActor
    func testStickyView() throws {
        let accomplishment = Accomplishment("Test Sticky")
        let view = StickyView(item: accomplishment)

        let _ = try XCTUnwrap(view.body)
    }
}
