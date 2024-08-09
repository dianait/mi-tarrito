import SwiftData
import SwiftUI

struct TarritoView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        HStack {
            Spacer()
            ZStack(alignment: .top) {
                Image(.tarrrito)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                    .frame(width: 100)

                Text("\(items.count)")
                    .font(.system(size: 20))
                    .padding(.top, 25)
                    .padding(.trailing, 8)
                    .bold()
            }
        }
    }
}

#Preview {
    TarritoView()
        .modelContainer(for: Item.self, inMemory: true)
}


