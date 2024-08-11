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
                        .padding(.top, 10)
                        .frame(width: 100)
                    
                    Text("\(items.count)")
                        .font(.system(size: 20))
                        .padding(.top, 27)
                        .bold()
                }
                .padding(.trailing, -15)
            }
        }
    }
}

#Preview {
    TarritoView()
        .modelContainer(for: Item.self, inMemory: true)
}


