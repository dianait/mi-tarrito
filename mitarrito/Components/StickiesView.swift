import SwiftData
import SwiftUI

struct StickiesView: View {
    @Query(sort: \Accomplishment.date, order: .reverse) private var items: [Accomplishment]
    @Binding var mode: Mode

    var lastMessage: String {
        switch mode {
        case .view: items.first?.text ?? ""
        case .edit: ""
        }
    }

    var body: some View {
        HStack {
            ZStack {
                StickyView(item: Accomplishment("Otro y otro", color: "soft-green"))
                    .offset(x: -70, y: -30)
                    .rotationEffect(Angle(degrees: -20))
                StickyView(item: Accomplishment("Otro más!", color: "soft-blue"))
                    .offset(x: 70, y: -30)
                    .rotationEffect(Angle(degrees: 20))
                StickyView(item: Accomplishment("🎉 Tu primer logro aquí", color: "soft-orange"))
                    .offset(x: 10, y: 30)
                    .rotationEffect(Angle(degrees: 10))
                StickyView(item: Accomplishment(lastMessage, color: "soft-yellow"))
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
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
