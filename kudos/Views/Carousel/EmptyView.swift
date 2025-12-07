import SwiftUI

struct EmptyStateView: View {
    @Environment(\.dismiss) private var dismiss
    private let cardWidth: CGFloat = 0.90
    private let circleSize: CGFloat = 90
    private let iconSize: CGFloat = .init(Size.extraExtraLarge.rawValue)

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Spacer()

                cardView(width: min(geometry.size.width * cardWidth, 500))

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color("MainBackground"))
        }
    }

    private func cardView(width: CGFloat) -> some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: CGFloat(Size.extraLarge.rawValue))
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange, Color.orange.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(backgroundCircles())
                .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 10)
                .frame(width: width)

            VStack(alignment: .center, spacing: CGFloat(Size.mediumSmall.rawValue)) {
                Spacer().frame(height: CGFloat(Size.extraExtraLarge.rawValue))

                cardHeaderContent()
                benefitsContent()
                addButton()
            }
            .padding(.vertical, CGFloat(Size.extraExtraLarge.rawValue))
            .padding(.horizontal, CGFloat(Size.large.rawValue))
            topCircleWithStar()
                .offset(y: -45)
        }
    }

    private func backgroundCircles() -> some View {
        ForEach(0 ..< 15, id: \.self) { _ in
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 20, height: 20)
                .offset(
                    x: CGFloat.random(in: -150 ... 150),
                    y: CGFloat.random(in: -250 ... 250)
                )
        }
    }

    private func cardHeaderContent() -> some View {
        VStack(spacing: CGFloat(Size.extraSmall.rawValue)) {
            Image(systemName: Icon.chart.rawValue)
                .font(.system(size: iconSize))
                .foregroundColor(.white.opacity(0.8))
                .padding(.bottom, CGFloat(Size.extraSmall.rawValue))

            Text(Copies.Carrusel.EmptyState.title)
                .font(.system(size: CGFloat(Size.large.rawValue), weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text(Copies.Carrusel.EmptyState.description)
                .font(.system(size: CGFloat(Size.medium.rawValue)))
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, CGFloat(Size.extraSmall.rawValue))
                .padding(.bottom, CGFloat(Size.extraSmall.rawValue))
        }
    }

    private func benefitsContent() -> some View {
        VStack(alignment: .leading, spacing: CGFloat(Size.extraSmall.rawValue)) {
            benefitRow(icon: Icon.check.rawValue, text: Copies.Carrusel.EmptyState.benefit1)
            benefitRow(icon: Icon.chartGrowth.rawValue, text: Copies.Carrusel.EmptyState.benefit2)
            benefitRow(icon: Icon.trophy.rawValue, text: Copies.Carrusel.EmptyState.benefit3)
        }
        .padding(.vertical, CGFloat(Size.extraSmall.rawValue))
    }

    private func benefitRow(icon: String, text: String) -> some View {
        HStack(spacing: CGFloat(Size.small.rawValue)) {
            Image(systemName: icon)
                .font(.system(size: CGFloat(Size.extraSmall.rawValue), weight: .semibold))
                .foregroundColor(.white)

            Text(text)
                .font(.system(size: CGFloat(Size.mediumSmall.rawValue)))
                .foregroundColor(.white.opacity(0.95))
        }
    }

    private func addButton() -> some View {
        Button(action: { dismiss() }) {
            HStack {
                Image(systemName: Icon.plus.rawValue)
                    .font(.system(size: CGFloat(Size.mediumLarge.rawValue)))

                Text(Copies.Carrusel.EmptyState.addNewButton)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, CGFloat(Size.extraExtraLarge.rawValue))
            .padding(.vertical, CGFloat(Size.mediumSmall.rawValue))
            .background(Capsule().fill(Color.white))
            .foregroundColor(.orange)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
        }
        .padding(.top, CGFloat(Size.mediumSmall.rawValue))
    }

    private func topCircleWithStar() -> some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.white.opacity(0.9)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: circleSize, height: circleSize)
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)

            Image(systemName: Icon.star.rawValue)
                .font(.system(size: iconSize, weight: .bold))
                .foregroundColor(.orange)
                .shadow(color: Color.orange.opacity(0.5), radius: 2, x: 0, y: 0)
        }
    }
}

#if targetEnvironment(simulator)
    #Preview {
        EmptyStateView()
            .preferredColorScheme(.dark)
    }
#endif
