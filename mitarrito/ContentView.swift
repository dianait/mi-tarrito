import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        IntroView(){
            text in
            addItem(text: text)
        }
    }
    
    private func addItem(text: String) {
        withAnimation {
            let newItem = Item(text)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
