import SwiftUI

struct BackgroundImageView: View {
    var color: String

    var body: some View {
        Image("postit")
            .resizable()
            .colorMultiply(Color.fromString(color))
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
    }
}

#Preview {
    Group {
        BackgroundImageView(color: "yellow")
        BackgroundImageView(color: "green")
    }
}
