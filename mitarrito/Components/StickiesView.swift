import SwiftData
import SwiftUI

struct StickiesView: View {
    @Query(sort: \Accomplishment.date, order: .reverse) private var items: [Accomplishment]
    @Binding var mode: Mode

    var lastMessage: String {
        switch mode {
        case .view: return items.first?.text ?? ""
        case .edit: return ""
        }
    }

    var body: some View {
        HStack {
            ZStack {
                backgroundStickies()
                StickyView(item: Accomplishment(lastMessage, color: "yellow"))
                    .offset(x: 0, y: 0)
                    .onTapGesture {
                        openEdit()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(A11y.StickiesView.label(lastMessage: lastMessage))
                    .accessibilityHint(A11y.StickiesView.hint)
                    .accessibilityAddTraits([.isButton])
            }
            .accessibilityAction(.default) {
                openEdit()
            }
        }
    }

    @ViewBuilder
    private func backgroundStickies() -> some View {
        Group {
            StickyView(item: Accomplishment("Otro y otro", color: "green"))
                .offset(x: -70, y: -30)
                .rotationEffect(Angle(degrees: -20))
                .accessibilityHidden(true)

            StickyView(item: Accomplishment("Otro más!", color: "blue"))
                .offset(x: 70, y: -30)
                .rotationEffect(Angle(degrees: 20))
                .accessibilityHidden(true)

            StickyView(item: Accomplishment("🎉 Tu primer logro aquí", color: "orange"))
                .offset(x: 10, y: 30)
                .rotationEffect(Angle(degrees: 10))
                .accessibilityHidden(true)
        }
    }

    private func openEdit() {
        withAnimation {
            mode = .edit
        }
    }
}

#Preview {
    StickiesView(mode: .constant(.view))
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
