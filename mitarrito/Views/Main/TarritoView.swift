import SwiftData
import SwiftUI

struct TarritoView: View {
    @Query private var items: [Accomplishment]
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        NavigationLink(destination: CarouselView()) {
            HStack {
                Spacer()
                ZStack(alignment: .top) {
                    Image(.tarrrito)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 75)

                    Text("\(items.count)")
                        .font(.system(
                            size: CGFloat(Size.medium.rawValue),
                            weight: .bold
                        ))
                        .foregroundColor(.white)
                        .padding(5)
                        .background(reduceTransparency ? Color.orange : Color.orange.opacity(0.9))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(
                            x: 1,
                            y: CGFloat(Size.mediumLarge.rawValue)
                        )
                        .shadow(color: reduceTransparency ? .clear : .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                }
                .padding(.trailing, Space.small)
            }
            .offset(x: CGFloat(Size.large.rawValue), y: .zero)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement()
        .accessibilityLabel(A11y.Tarrito.label(count: items.count))
        .accessibilityHint(A11y.Tarrito.hint)
        .accessibilityAddTraits([.isLink, .updatesFrequently])
        .accessibilityIdentifier(A11y.Tarrito.identifier)
        .minimumScaleFactor(0.8)
        .frame(minWidth: Space.extraLarge, minHeight: Space.extraLarge)
    }
}

#Preview {
    TarritoView()
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
