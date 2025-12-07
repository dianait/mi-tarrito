import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var items: [Accomplishment]

    var body: some View {
        MainView {
            text in
            addItem(text: text)
        }
    }

    private func addItem(text: String) {
        // Validate before creating Accomplishment
        let validationResult = AccomplishmentValidator.validateText(text)
        
        switch validationResult {
        case .success(let validatedText):
            do {
                let newItem = try Accomplishment(validatedText)
                modelContext.insert(newItem)
            } catch {
                // Log error but don't crash - validation should have caught this
                print("Error creating Accomplishment: \(error.localizedDescription)")
            }
        case .failure(let error):
            // Validation failed - log error
            // In a production app, you might want to show an alert to the user
            print("Validation error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Accomplishment.self, inMemory: true)
        .environmentObject(LanguageManager.shared) // Añade esto solo para el preview
}
