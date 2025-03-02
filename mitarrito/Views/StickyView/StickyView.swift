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
                        .font(.largeTitle)
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

#Preview("✏️ Edit Mode") {
    StickyView(item: itemMock){}
}
#endif
