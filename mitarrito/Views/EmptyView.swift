import SwiftUI

struct EmptyStateView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .top) {
                        VStack(alignment: .center, spacing: 16) {
                            Spacer().frame(height: 40)

                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 45))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.bottom, 10)

                            Text("¡Guarda tus logros!")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)

                            Text("Desbloquea todo tu potencial dándole valor a tus objetivos alcanzados")
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 10)
                                .padding(.bottom, 10)

                            VStack(alignment: .leading, spacing: 10) {
                                benefitRow(icon: "checkmark.circle.fill", text: "Aumenta tu motivación diaria")
                                benefitRow(icon: "chart.line.uptrend.xyaxis.circle.fill", text: "Mejora continua y medible")
                                benefitRow(icon: "trophy.fill", text: "Celebra tus victorias personales")
                            }
                            .padding(.vertical, 10)

                            Button(action: { dismiss() }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 20))

                                    Text("Añadir nuevo logro")
                                        .fontWeight(.bold)
                                }
                                .padding(.horizontal, 40)
                                .padding(.vertical, 16)
                                .background(Capsule().fill(Color.white))
                                .foregroundColor(.orange)
                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                            }
                            .padding(.top, 15)
                            .padding(.bottom, 10)
                        }
                        .padding(.vertical, 45)
                        .padding(.horizontal, 25)
                        .frame(width: min(geometry.size.width * 0.90, 500))
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.orange, Color.orange.opacity(0.8)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                ForEach(0 ..< 15) { _ in
                                    Circle()
                                        .fill(Color.white.opacity(0.1))
                                        .frame(width: 20, height: 20)
                                        .offset(
                                            x: CGFloat.random(in: -150 ... 150),
                                            y: CGFloat.random(in: -250 ... 250)
                                        )
                                }
                            }
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 10)

                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.white, Color.white.opacity(0.9)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: 90, height: 90)
                                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)

                            Image(systemName: "star.fill")
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.orange)
                                .shadow(color: Color.orange.opacity(0.5), radius: 2, x: 0, y: 0)
                        }
                        .offset(y: -45)
                    }
                    Spacer()
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.opacity(0.97))
        }
    }

    private func benefitRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            Text(text)
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.95))
        }
    }
}

#Preview {
    EmptyStateView()
}
