import SwiftData
import SwiftUI

struct TarritoView: View {
    @Query private var items: [Item]

    var body: some View {
        NavigationLink(destination: ImageGalleryCarouselView()) {
            HStack {
                Spacer()
                ZStack(alignment: .top) {
                    Image(.tarrrito)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)

                    Text("\(items.count)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(x: 1, y: 13)
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                }
                .padding(.trailing, 10)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Tarrito con \(items.count) elementos")
        .accessibilityHint("Toca para ver los elementos")
    }
}

#Preview {
    TarritoView()
        .modelContainer(for: Item.self, inMemory: true)
}

