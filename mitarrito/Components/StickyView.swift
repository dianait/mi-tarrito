import SwiftUI

struct StickyView: View {
    var text: String
    var color: Color

    init(text: String = "¡Hola, mundo!") {
            self.text = text
        	self.color =  Color(
                hue: Double.random(in: 0...1),
                saturation: Double.random(in: 0.3...0.7),
                brightness: Double.random(in: 0.7...1)
            )
        }

    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .topTrailing) {
                Image("postit")
                    .resizable()
                    .colorMultiply(color)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300)
                Text(text)
                    .font(.largeTitle)
                    .frame(width: 300, height: 300)
            }
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
