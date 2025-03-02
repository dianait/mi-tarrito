import SwiftData
import SwiftUI

struct TarritoView: View {
    @Query private var items: [Accomplishment]

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
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(x: 1, y: 22)
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                }
                .padding(.trailing, 10)
            }
            .offset(x: 25, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Tarrito con \(items.count) elementos")
        .accessibilityHint(A11y.hint)
    }
}

#Preview {
    TarritoView()
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
