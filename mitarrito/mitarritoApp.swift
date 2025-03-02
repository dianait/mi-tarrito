import SwiftData
import SwiftUI

@main
struct MiTarritoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Accomplishment.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(.white)
        }
        .modelContainer(sharedModelContainer)
    }
}
