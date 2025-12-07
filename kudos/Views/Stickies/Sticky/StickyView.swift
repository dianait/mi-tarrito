import SwiftUI

struct StickyView: View {
    var item: Accomplishment
    var delete: (() -> Void)? = nil

    var isEditMode: Bool {
        delete != nil
    }

    var widthOffset: CGFloat {
        isEditMode ? .zero : -CGFloat(Size.extraLarge.rawValue)
    }

    var heightOffset: CGFloat {
        isEditMode ?
            -CGFloat(Size.extraSmall.rawValue) :
            CGFloat(Size.mediumLarge.rawValue)
    }

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                BackgroundImageView(color: item.color)
                VStack {
                    if isEditMode {
                        DeleteButtonView(action: { delete?() })
                            .offset(
                                x: -CGFloat(Size.mediumLarge.rawValue),
                                y: CGFloat(Size.mediumLarge.rawValue)
                            )
                    }

                    ItemTextView(text: item.text)
                        .multilineTextAlignment(.center)
                        .offset(x: widthOffset, y: heightOffset)

                    if isEditMode {
                        DateLabelView(date: item.date)
                            .offset(x: Dimensions.dateLabelXOffset, y: Dimensions.dateLabelYOffset)
                            .accessibilityLabel(A11y.StickyView.dateLabel(date: item.date))
                    }
                }
                .padding()
            }
        }
        .frame(width: Dimensions.stickyWidth, height: Dimensions.stickyHeight)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(A11y.StickyView.label)
    }
}

#if targetEnvironment(simulator)
    let itemMock = Accomplishment(
        validatedText: "🎉 Tu primer logro aquí",
        validatedColor: "yellow"
    )

    #Preview("👀 View Mode") {
        StickyView(item: itemMock)
    }

    #Preview("✏️ Texto largo") {
        StickyView(item: Accomplishment(
            validatedText: "🎉 Tu primer logro aquí esto es un texto muy largo que necestio de una línea para que se note el reajuste del layout",
            validatedColor: "yellow"
        )) {}
    }

    #Preview("✏️ Texto más largo") {
        StickyView(item: Accomplishment(
            validatedText: "🎉 Tu primer logro aquí esto es un texto muy largo que necestio de una línea para que se note el reajuste del layout y el texto sea todavía mas largo",
            validatedColor: "yellow"
        )) {}
    }

    #Preview("✏️ Edit Mode") {
        StickyView(item: itemMock) {}
    }
#endif
