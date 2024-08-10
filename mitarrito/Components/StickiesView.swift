import SwiftUI
import SwiftData

struct StickiesView: View {
    @Query(sort: \Item.date, order: .reverse) private var items: [Item]

    var body: some View {
        HStack {
            ZStack {
                StickyView(item: Item(text: "Otro y otro", color: "green"))
                    .offset(x: -70, y: -30)
                    .rotationEffect(Angle(degrees: -20))
                StickyView(item: Item(text: "Otro más!", color: "pink"))
                    .offset(x: 70, y: -30)
                    .rotationEffect(Angle(degrees: 20))
                StickyView(item: Item(text: items.first?.text ?? "🎉 Tu primer logro aquí", color: "orange"))
                    .offset(x: 10, y: 30)
                    .rotationEffect(Angle(degrees: 10))
                StickyView(item: Item(text: "", color: "yellow"))
                    .offset(x: 0, y: 0)

            }
        }
    }
}

#Preview {
    StickiesView()
        .modelContainer(for: Item.self, inMemory: true)
}
