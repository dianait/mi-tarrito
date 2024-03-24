import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                Spacer()
                NavigationLink(destination: ListView()) {
                    TarritoView()
                }
            }
            AddItemVIew { text in
                addItem(text: text)
            }
        }
    }

    private func addItem(text: String) {
        withAnimation {
            let newItem = Item(timestamp: Date(), text: text)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
