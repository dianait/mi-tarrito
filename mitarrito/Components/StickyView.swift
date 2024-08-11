import SwiftUI

struct StickyView: View {
    var item: Item
    var delete: ((Item) -> Void)?

    init(item: Item = Item(text: "🎉 Tu primer logro aquí", color: "yellow"), delete: ((Item) -> Void)? = nil) {
        self.item = item
        self.delete = delete
    }

    var isEditMode: Bool {
        delete != nil
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
                if let delete, isEditMode {
                    HStack {
                        Spacer()
                        Button(action: { delete(item) }) {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.red)
                                .clipShape(Circle())
                                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                    }
                    .offset(x: -40, y: 37)
                }

                Text(item.text)
                    .font(.largeTitle)
                    .frame(width: 300, height: 300)
                if isEditMode {
                    HStack {
                        Spacer()
                        Text(item.date, style: .date)
                            .font(.caption)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                            .overlay(
                                Capsule()
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .padding([.bottom, .trailing], 10)
                    }
                    .offset(x: -185, y: 15)
                }

            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    StickyView()
}

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
