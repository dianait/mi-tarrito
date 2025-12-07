import SwiftData
import SwiftUI

@main
struct KudosApp: App {
    @StateObject private var languageManager = LanguageManager.shared
    @State private var modelContainerError: Error?
    @State private var modelContainer: ModelContainer?

    init() {
        // Initialize ModelContainer safely
        let schema = Schema([
            Accomplishment.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            _modelContainer = State(initialValue: try ModelContainer(for: schema, configurations: [modelConfiguration]))
        } catch {
            // Instead of fatalError, save the error and use an in-memory container as fallback
            print("Error creating ModelContainer: \(error.localizedDescription)")
            _modelContainerError = State(initialValue: error)
            // Try to create an in-memory container as fallback
            do {
                let fallbackConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                _modelContainer = State(initialValue: try ModelContainer(for: schema, configurations: [fallbackConfiguration]))
                print("Using in-memory ModelContainer as fallback")
            } catch {
                print("Error creating fallback ModelContainer: \(error.localizedDescription)")
                _modelContainer = State(initialValue: nil)
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            if let container = modelContainer {
                ContentView()
                    .background(Color("MainBackground"))
                    .environmentObject(languageManager)
                    .modelContainer(container)
            } else {
                ErrorView(error: modelContainerError)
                    .environmentObject(languageManager)
            }
        }
    }
}
