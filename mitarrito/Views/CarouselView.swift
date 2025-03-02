import Foundation
import SwiftUI
import SwiftData

struct CarouselView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.date, order: .reverse) private var items: [Item]
    @State private var currentIndex: Int = 0
    @State private var translation: CGFloat = 0

    var body: some View {
        if items.isEmpty {
            EmptyStateView()
        } else {
            ZStack {
                ForEach(Array(Array(items.prefix(20)).shuffled().enumerated()), id: \.element.id) { index, item in
                    StickyView(item: item, delete: { removeItem(item: item) })
                        .rotation3DEffect(
                            .degrees(Double(cardRotation(index))),
                            axis: (x: 0, y: 1, z: 0),
                            anchor: .center,
                            perspective: 0.5
                        )
                        .offset(x: cardOffset(index))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        translation = gesture.translation.width
                    }
                    .onEnded { gesture in
                        withAnimation {
                            if gesture.translation.width < -50 && currentIndex < items.count - 1 {
                                currentIndex += 1
                            } else if gesture.translation.width > 50 && currentIndex > 0 {
                                currentIndex -= 1
                            }
                            translation = 0
                        }
                    }
            )
        }
    }

    private func removeItem(item: Item) {
        withAnimation {
            if let item = items.first {
                modelContext.delete(item)
            }
        }
    }

    private func cardRotation(_ index: Int) -> CGFloat {
        let cardOffset = CGFloat(index - currentIndex)
        return cardOffset * 15
    }

    private func cardOffset(_ index: Int) -> CGFloat {
        let cardOffset = CGFloat(index - currentIndex)
        return cardOffset * 300 + translation
    }
}

#Preview {
    CarouselView()
        .modelContainer(for: Item.self, inMemory: true)
}
