import SwiftUI

struct TimelineView: View {
    private var primaryColor: Color { Color.orange }
    var body: some View {
        VStack(alignment: .leading, spacing: Space.small) {
            HStack {
                Image(systemName: "book.fill")
                    .font(.title)
                    .foregroundColor(primaryColor)

                Text("Un poco de historia...")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(primaryColor)
            }
            .padding(.vertical, Space.large)

            GeometryReader { _ in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.orange.opacity(0.5))
                        .frame(width: 2)
                        .padding(.leading, 10)
                    VStack(spacing: Space.large) {
                        TimelineItem(
                            icon: "lightbulb.fill",
                            title: "Todo empezó en la LicorcaConf",
                            description: "En una charla sobre el síndrome del Impostor, Silvia comentó que tenía una carpeta donde guardaba las cosas buenas que le pasaban en el trabajo."
                        )
                        .padding(.leading, 4)
                        TimelineItem(
                            icon: "brain.head.profile",
                            title: "Me compré un tarrito físico",
                            description: "Y empecé a llenarlo de notas con cosas que me hacían sentirme bien en el trabajo. Una manera práctica de recordar mis logros."
                        )
                        TimelineItem(
                            icon: "bird.fill",
                            title: "Lo compartí en redes sociales",
                            description: "Y el resto es historia... Mi tarrito se hizo famoso, mencionándose desde el techFest hasta en el Software Crafters de Barcelona ❤️"
                        )
                        TimelineItem(
                            icon: "iphone.gen3",
                            title: "Y esta es la versión digital",
                            description: "Quería publicar una app desde hace mucho tiempo, y qué mejor forma que con mi tarrito en versión digital. ¡Para que todos puedan tener su propio tarrito de logros!"
                        )
                    }
                }

                .padding(.leading, Space.small)
            }
        }
        SocialLinks()
    }
}

struct TimelineItem: View {
    let icon: String
    let title: String
    let description: String

    private let circleSize: CGFloat = 14
    private let circleBackgroundSize: CGFloat = 24
    private let iconSize: CGFloat = 18
    private let spacing: CGFloat = 20

    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            ZStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: circleSize, height: circleSize)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .background(
                        Circle()
                            .fill(Color.white)
                            .frame(width: circleBackgroundSize, height: circleBackgroundSize)
                            .shadow(color: Color.orange.opacity(0.3), radius: 2, x: 0, y: 0)
                    )
            }
            .frame(width: 35, alignment: .leading)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: Space.small) {
                    Image(systemName: icon)
                        .foregroundColor(.orange)
                        .font(.system(size: iconSize))

                    Text(title)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                }

                Text(description)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading, 28)
            }
        }
    }
}

#if targetEnvironment(simulator)
    #Preview {
        TimelineView()
            .padding()
    }
#endif
