import SwiftUI

struct StickyView: View {
    var text: String
    var color: Color
    var date: Date

    init(text: String = "¡Hola, mundo!", date: Date = Date()) {
        self.text = text
        self.date = date
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
                Text(date, style: .date)
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
