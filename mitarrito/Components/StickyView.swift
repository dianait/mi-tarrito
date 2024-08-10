import SwiftUI

struct StickyView: View {
    var item: Item

    init(item: Item = Item(text: "🎉 Tu primer logro aquí", color: "yellow")) {
        self.item = item
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .topTrailing) {

                Image("postit")
                    .resizable()
                    .colorMultiply(Color.fromString(item.color))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300)
                Text(item.text)
                    .font(.largeTitle)
                    .frame(width: 300, height: 300)
                Text(item.date, style: .date)
                    .font(.caption2)
                    .padding(8)
                    .offset(x: -35, y: 35)
            }

        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    StickyView()
}

import SwiftUI

extension Color {
    static func fromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
        case "black":
            return .black
        case "blue":
            return .blue
        case "brown":
            return .brown
        case "clear":
            return .clear
        case "cyan":
            return .cyan
        case "gray":
            return .gray
        case "green":
            return .green
        case "indigo":
            return .indigo
        case "mint":
            return .mint
        case "orange":
            return .orange
        case "pink":
            return .pink
        case "purple":
            return .purple
        case "red":
            return .red
        case "teal":
            return .teal
        case "white":
            return .white
        case "yellow":
            return .yellow
        default:
            return .gray 
        }
    }
}
