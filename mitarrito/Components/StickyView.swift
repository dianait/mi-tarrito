import SwiftUI

struct StickyView: View {
    var text: String
    var color: Color = .yellow
    var borderColor: Color = .orange

    init(text: String = "¡Hola, mundo!", color: Color = .yellow, borderColor: Color = .orange) {
            self.text = text
            self.color = color
            self.borderColor = borderColor
        }

    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .font(.largeTitle)
                .frame(width: 200, height: 200)
                .background(color)
                .clipShape(BentCornerShape(corner: .bottomRight, size: 20))
                .overlay(BentCornerShape(corner: .bottomRight, size: 20)
                    .stroke(borderColor, lineWidth: 2))
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            Spacer()
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    StickyView()
}

struct BentCornerShape: Shape {
    var corner: UIRectCorner
    var size: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width - size, y: 0))
        path.addLine(to: CGPoint(x: width, y: size))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()

        return path
    }
}
