import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: Space.small) {
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
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    HeaderView()
}
