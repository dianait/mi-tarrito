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
                    .background(.white)
                    .environmentObject(languageManager)
                    .modelContainer(container)
            } else {
                // Elegant error view instead of crash
                ErrorView(error: modelContainerError)
                    .environmentObject(languageManager)
            }
        }
    }
}

// Error view to display when data initialization fails
struct ErrorView: View {
    let error: Error?
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.purple)
            Text("Error loading application")
                .font(.headline)
            if let error = error {
                Text(error.localizedDescription)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            Text("Please restart the application")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
