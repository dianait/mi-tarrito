import SwiftData
import SwiftUI

struct StickiesView: View {
    @Query(sort: \Accomplishment.date, order: .reverse) private var items: [Accomplishment]
    @Binding var mode: Mode

    var lastMessage: String {
        switch mode {
        case .view: return items.first?.text ?? ""
        case .edit: return "" // In edit mode, don't show placeholder in StickyView
        }
    }

    var body: some View {
        HStack {
            ZStack {
                backgroundStickies()
                StickyView(
                    item: Accomplishment(
                        validatedText: lastMessage.isEmpty ? " " : lastMessage,
                        validatedColor: Copies.Colors.yellow.rawValue
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
                .accessibilityIdentifier(A11y.StickiesView.stickie)
            }
            .accessibilityAction(.default) {
                openEdit()
            }
        }
    }

    @ViewBuilder
    private func backgroundStickies() -> some View {
        Group {
            StickyView(item: Accomplishment(validatedText: Copies.StickisView.accomplishmentExample3, validatedColor: Copies.Colors.green.rawValue))
                .offset(
                    x: -CGFloat(Size.extraExtraExtraLarge.rawValue),
                    y: -CGFloat(Size.extraExtraLarge.rawValue)
                )
                .rotationEffect(Angle(degrees: -CGFloat(Size.mediumLarge.rawValue)))
                .accessibilityHidden(true)

            StickyView(
                item: Accomplishment(
                    validatedText: Copies.StickisView.accomplishmentExample2,
                    validatedColor: Copies.Colors.blue.rawValue
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
                    validatedText: Copies.StickisView.accomplishmentExample1,
                    validatedColor: Copies.Colors.orange.rawValue
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
        mode = .edit
    }
}

#Preview {
    StickiesView(mode: .constant(.view))
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
