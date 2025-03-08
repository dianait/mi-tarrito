import SwiftUI

struct StickyView: View {
    var item: Accomplishment
    var delete: (() -> Void)? = nil
    
    var isEditMode: Bool {
        delete != nil
    }

    var widthOffset: CGFloat {
        isEditMode ? 0 : -30
    }

    var heightOffset: CGFloat {
        isEditMode ? -10 : 20
    }

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                BackgroundImageView(color: item.color)
                VStack {
                    if isEditMode {
                        DeleteButtonView(action: { delete?() })
                            .offset(x: -20, y: 20)
                    }
                    
                    ItemTextView(text: item.text)
                        .multilineTextAlignment(.center)
                        .offset(x: widthOffset, y: heightOffset)

                    if isEditMode {
                        DateLabelView(date: item.date)
                            .offset(x: -180, y: -250)
                    }
                }
                .padding()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#if targetEnvironment(simulator)
let itemMock =  Accomplishment(
    "🎉 Tu primer logro aquí",
    color: "yellow")

#Preview("👀 View Mode") {
    StickyView(item: itemMock)
}

#Preview("✏️ Texto largo") {
    StickyView(item:  Accomplishment(
        "🎉 Tu primer logro aquí esto es un texto muy largo que necestio de una línea para que se note el reajuste del layout",
        color: "yellow")){}
}

#Preview("✏️ Texto más largo") {
    StickyView(item:  Accomplishment(
        "🎉 Tu primer logro aquí esto es un texto muy largo que necestio de una línea para que se note el reajuste del layout y el texto sea todavía mas largo",
        color: "yellow")){}
}


#Preview("✏️ Edit Mode") {
    StickyView(item: itemMock){}
}
#endif
