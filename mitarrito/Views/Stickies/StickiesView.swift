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
                StickyView(
                    item: Accomplishment(
                        lastMessage,
                        color: Copies.Colors.yellow.rawValue
                    )
                )
                .offset(x: .zero, y: .zero)
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
            StickyView(item: Accomplishment(Copies.StickisView.accomplishmentExample3, color: Copies.Colors.green.rawValue))
                .offset(
                    x: -CGFloat(Size.extraExtraExtraLarge.rawValue),
                    y: -CGFloat(Size.extraExtraLarge.rawValue)
                )
                .rotationEffect(Angle(degrees: -CGFloat(Size.mediumLarge.rawValue)))
                .accessibilityHidden(true)

            StickyView(
                item: Accomplishment(
                    Copies.StickisView.accomplishmentExample2,
                    color: Copies.Colors.blue.rawValue
                )
            )
            .offset(
                x: CGFloat(Size.extraExtraExtraLarge.rawValue),
                y: -CGFloat(Size.extraLarge.rawValue)
            )
            .rotationEffect(Angle(degrees: CGFloat(Size.mediumLarge.rawValue)))
            .accessibilityHidden(true)

            StickyView(
                item: Accomplishment(
                    Copies.StickisView.accomplishmentExample1,
                    color: Copies.Colors.orange.rawValue
                )
            )
            .offset(
                x: CGFloat(Size.extraSmall.rawValue),
                y: CGFloat(Size.extraLarge.rawValue)
            )
            .rotationEffect(Angle(degrees: CGFloat(Size.extraSmall.rawValue)))
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
