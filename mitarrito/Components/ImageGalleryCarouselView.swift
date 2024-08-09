import Foundation
import SwiftUI
import SwiftData

struct ImageGalleryCarouselView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    var images: [String] = []
    @State private var currentIndex: Int = 0
    @State private var translation: CGFloat = 0

    init() {
        images = Array(repeating: "postit", count: items.count)
    }

    var body: some View {
        ZStack {
            ForEach(0..<images.count, id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .scaledToFit()
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
                    if gesture.translation.width < -50 {
                        withAnimation {
                            currentIndex = (currentIndex + 1) % images.count
                        }
                    } else if gesture.translation.width > 50 {
                        withAnimation {
                            currentIndex = (currentIndex - 1 + images.count) % images.count
                        }
                    }
                    translation = 0
                }
        )
        .padding()
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
    ImageGalleryCarouselView()
        .modelContainer(for: Item.self, inMemory: true)
}
