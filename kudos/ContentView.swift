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
        let newItem = Accomplishment(text)
        modelContext.insert(newItem)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Accomplishment.self, inMemory: true)
        .environmentObject(LanguageManager.shared) // Añade esto solo para el preview
}
