import SwiftUI

struct StickyView: View {
    var item: Item
    var delete: (() -> Void)? = nil
    
    var isEditMode: Bool {
        delete != nil
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
                        .foregroundColor(.gray.opacity(0.8))
                        .offset(x: -30, y: 20)
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
let itemMock =  Item(
    "🎉 Tu primer logro aquí",
    color: "yellow")

#Preview("👀 View Mode") {
    StickyView(item: itemMock)
}

#Preview("✏️ Edit Mode") {
    StickyView(item: itemMock){}
}
#endif
