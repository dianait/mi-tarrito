import SwiftUI
import SwiftData

struct IntroView: View {
    var body: some View {
        VStack {
            TarritoView()
                .offset(x: 0, y: 59)
            Spacer()
            StickiesView()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    IntroView()
        .modelContainer(for: Item.self, inMemory: true)
}
