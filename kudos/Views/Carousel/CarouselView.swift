import Foundation
import SwiftData
import SwiftUI

struct CarouselView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Accomplishment.date, order: .reverse) private var items: [Accomplishment]
    @State private var currentIndex: Int = 0
    @State private var translation: CGFloat = 0

    // Calculate the range of visible items to optimize performance
    private var visibleRange: Range<Int> {
        let windowSize = 3 // Renders current item + 1 on each side
        let start = max(0, currentIndex - 1)
        let end = min(items.count, currentIndex + windowSize)
        return start..<end
    }
    
    var body: some View {
        if items.isEmpty {
            EmptyStateView()
        } else {
            ZStack {
                // Only render visible items to improve performance
                ForEach(Array(visibleRange), id: \.self) { index in
                    if index < items.count {
                        let item = items[index]
                        StickyView(item: item, delete: { removeItem(item: item) })
                            .rotation3DEffect(
                                .degrees(Double(cardRotation(index))),
                                axis: (x: 0, y: 1, z: 0),
                                anchor: .center,
                                perspective: 0.5
                            )
                            .offset(x: cardOffset(index))
                            .opacity(abs(index - currentIndex) > 2 ? 0 : 1) // Hide items that are too far away
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        translation = gesture.translation.width
                    }
                    .onEnded { gesture in
                        withAnimation {
                            if gesture.translation.width < -50, currentIndex < items.count - 1 {
                                currentIndex += 1
                            } else if gesture.translation.width > 50, currentIndex > 0 {
                                currentIndex -= 1
                            }
                            translation = 0
                        }
                    }
            )
        }
    }

    private func removeItem(item: Accomplishment) {
        withAnimation {
            // Save current index before deleting
            let itemIndex = items.firstIndex(where: { $0.id == item.id }) ?? currentIndex
            modelContext.delete(item)
            
            // Adjust index after deletion
            // If we delete the last item or one after the current, adjust the index
            if itemIndex <= currentIndex && currentIndex > 0 {
                currentIndex -= 1
            } else if currentIndex >= items.count - 1 {
                currentIndex = max(0, items.count - 2)
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
        .modelContainer(for: Accomplishment.self, inMemory: true)
}