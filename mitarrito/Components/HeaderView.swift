import SwiftUI

struct HeaderView: View {
    @Binding var mode: Mode
    @Binding var text: String

    var body: some View {
        VStack(spacing: Space.small) {
            if mode == .edit && !text.isEmpty {
                Text("¿Has terminado?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)

                Text("Desliza hacia arriba para guardar")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

            } else {
                Text("¡Es hora de celebrar tus logros!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)

                Text("Pulsa en la nota amarilla para empezar")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.yellow.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.orange.opacity(0.5), lineWidth: 2)
                )
        )
        .padding(.horizontal)
        .padding(.vertical, Space.medium)
        .frame(width: 600, height: 60)
    }
}

#Preview("✍️ Edit mode") {
    HeaderView(mode: .constant(.edit), text: .constant(""))
}

#Preview("👀 View mode") {
    HeaderView(mode: .constant(.view), text: .constant(""))
}
