import Foundation
import SwiftData
import SwiftUI

struct CarouselView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Accomplishment.date, order: .reverse) private var items: [Accomplishment]

    var body: some View {
        if items.isEmpty {
            EmptyStateView()
        } else {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(items, id: \Accomplishment.id) { item in
                        StickyView(item: item, delete: { removeItem(item: item) })
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                    }
                }
                .padding()
            }
        }
    }

    private func removeItem(item: Accomplishment) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}

#Preview {
    CarouselView()
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
