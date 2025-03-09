import Foundation
import SwiftData
import SwiftUI

struct CarouselView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Accomplishment.date, order: .reverse) private var items: [Accomplishment]
    @State private var currentIndex: Int = 0

    var body: some View {
        if items.isEmpty {
            EmptyStateView()
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(items) { item in
                        StickyView(item: item, delete: { removeItem(item: item) })
                            .padding()
                            .transition(.opacity)
                    }
                }
                .padding()
            }
            .scrollTargetBehavior(.paging)
        }
    }

    private func removeItem(item: Accomplishment) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    CarouselView()
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
#endif
