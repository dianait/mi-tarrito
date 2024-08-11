import SwiftUI

struct StickyView: View {
    var item: Item
    var delete: ((Item) -> Void)? = nil
    
    var isEditMode: Bool {
        delete != nil
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                BackgroundImageView(color: item.color)
                VStack {
                    if isEditMode {
                        DeleteButtonView(action: { delete?(item) })
                            .offset(x: -20, y: 20)
                        
                    }
                    
                    ItemTextView(text: item.text)
                        .offset(x: -6, y: -21)
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
    text: "🎉 Tu primer logro aquí",
    color: "yellow")

#Preview("👀 View Mode") {
    StickyView(item: itemMock)
}

#Preview("✏️ Edit Mode") {
    StickyView(item: itemMock) {_ in }
}
#endif
