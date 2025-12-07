@testable import kudos
import SwiftData
import SwiftUI
import XCTest

final class SwiftDataIntegrationTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!

    override func setUp() async throws {
        let schema = Schema([Accomplishment.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        modelContext = ModelContext(modelContainer)
    }

    func testSaveAndFetchAccomplishment() throws {
        let text = "Test logro para SwiftData"
        let color = "yellow"

        let accomplishment = Accomplishment(text, color: color)
        modelContext.insert(accomplishment)

        let descriptor = FetchDescriptor<Accomplishment>()
        let fetchedAccomplishments = try modelContext.fetch(descriptor)

        XCTAssertEqual(fetchedAccomplishments.count, 1)
        XCTAssertEqual(fetchedAccomplishments.first?.text, text)
        XCTAssertEqual(fetchedAccomplishments.first?.color, color)
    }

    func testDeleteAccomplishment() throws {
        let accomplishment = Accomplishment("Logro para eliminar")
        modelContext.insert(accomplishment)

        var descriptor = FetchDescriptor<Accomplishment>()
        var fetchedAccomplishments = try modelContext.fetch(descriptor)
        XCTAssertEqual(fetchedAccomplishments.count, 1)

        modelContext.delete(accomplishment)

        descriptor = FetchDescriptor<Accomplishment>()
        fetchedAccomplishments = try modelContext.fetch(descriptor)
        XCTAssertEqual(fetchedAccomplishments.count, 0)
    }

    func testFetchWithSorting() throws {
        let oldDate = Date(timeIntervalSinceNow: -86400) // Ayer
        let newDate = Date()

        let oldAccomplishment = Accomplishment("Logro antiguo")
        oldAccomplishment.date = oldDate

        let newAccomplishment = Accomplishment("Logro nuevo")
        newAccomplishment.date = newDate

        modelContext.insert(oldAccomplishment)
        modelContext.insert(newAccomplishment)

        var descriptor = FetchDescriptor<Accomplishment>(sortBy: [SortDescriptor(\.date)])
        var fetchedAccomplishments = try modelContext.fetch(descriptor)

        XCTAssertEqual(fetchedAccomplishments.count, 2)
        XCTAssertEqual(fetchedAccomplishments.first?.text, "Logro antiguo")

        descriptor = FetchDescriptor<Accomplishment>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        fetchedAccomplishments = try modelContext.fetch(descriptor)

        XCTAssertEqual(fetchedAccomplishments.count, 2)
        XCTAssertEqual(fetchedAccomplishments.first?.text, "Logro nuevo")
    }
}
