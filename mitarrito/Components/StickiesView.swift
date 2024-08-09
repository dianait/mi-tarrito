import SwiftUI
import SwiftData

struct StickiesView: View {
@Query(sort: \Item.timestamp, order: .reverse) private var items: [Item]

    var body: some View {
        HStack {
            ZStack {
                StickyView(color: .teal, borderColor: .blue)
                    .offset(x: -70, y: -30)
                    .rotationEffect(Angle(degrees: -20))
                StickyView(color: .green, borderColor: .mint)
                    .offset(x: 70, y: -30)
                    .rotationEffect(Angle(degrees: 20))
                StickyView(text: items.first?.text ?? "🎉 Tu primer logro aquí", color: .yellow, borderColor: .orange)
                                   .offset(x: 0, y: 0)
            }
        }
    }
}

#Preview {
    StickiesView()
        .modelContainer(for: Item.self, inMemory: true)
}
