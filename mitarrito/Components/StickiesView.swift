import SwiftUI
import SwiftData

struct StickiesView: View {
    @Query(sort: \Item.date, order: .reverse) private var items: [Item]
    @Binding  var mode: Mode

    var lastMessage: String {
		switch mode {
            case .view: items.first?.text ?? ""
            case .edit: ""
        }
    }

    var body: some View {
        HStack {
            ZStack {
                StickyView(item: Item("Otro y otro", color: "soft-green"))
                    .offset(x: -70, y: -30)
                    .rotationEffect(Angle(degrees: -20))
                StickyView(item: Item("Otro más!", color: "soft-blue"))
                    .offset(x: 70, y: -30)
                    .rotationEffect(Angle(degrees: 20))
                StickyView(item: Item("🎉 Tu primer logro aquí", color: "soft-orange"))
                    .offset(x: 10, y: 30)
                    .rotationEffect(Angle(degrees: 10))
                StickyView(item: Item(lastMessage, color: "soft-yellow"))
                    .offset(x: 0, y: 0)
                    .onTapGesture {
                        openEdit()
                    }

            }
        }
    }


    private func openEdit() {
        mode = .edit
    }
}

#Preview {
    StickiesView(mode: .constant(.view))
        .modelContainer(for: Item.self, inMemory: true)
}
