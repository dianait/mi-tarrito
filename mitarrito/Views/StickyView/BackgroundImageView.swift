import SwiftUI

struct BackgroundImageView: View {
    var color: String

    var body: some View {
        Image("postit")
            .resizable()
            .colorMultiply(Color.fromString(color))
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}

#Preview {
    Group {
        BackgroundImageView(color: "soft-yellow")
        BackgroundImageView(color: "soft-green")
    }
}
