import SwiftUI

struct HeaderView: View {
    @Binding var mode: Mode

    var body: some View {
        VStack(spacing: Space.small) {
            if mode == .edit {
                Text("Escribe y desliza hacia arriba")
                    .font(.headline)
                    .foregroundColor(.orange)

                Image(systemName: "arrow.up")
                    .foregroundColor(.orange)
                    .font(.system(size: 16, weight: .bold))

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
        // .transition(.move(edge: .top).combined(with: .opacity))
        .padding(.vertical, Space.medium)
        .frame(height: 60)
        // .transition(.opacity)
        // .animation(.easeInOut(duration: 0.3), value: mode)
    }
}

#Preview("✍️ Edit mode") {
    HeaderView(mode: .constant(.edit))
}

#Preview("👀 View mode") {
    HeaderView(mode: .constant(.view))
}
