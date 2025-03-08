import SwiftUI
import Foundation

struct AboutView: View {
    @State private var scrollID = UUID()
    var body: some View {
        VStack(alignment: .leading, spacing: Space.medium) {
            Headline()

            SectionCard(
                title: "Tu privacidad es nuestra prioridad",
                icon: "lock.shield.fill",
                content: {
                    Text("Cada logro que guardes permanecerá exclusivamente en tu dispositivo. Tus datos nunca abandonan tu teléfono.")
                        .fixedSize(horizontal: false, vertical: true)
                }
            )
            TimelineView()
                .id(scrollID)
        }
        .padding()
    }
}

struct Headline: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Space.small) {
                Text("🫙 Mi Tarrito")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.orange)

                Text("Un espacio para guardar tus logros")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "sparkles")
                .font(.system(size: 38))
                .foregroundColor(.orange)
        }
        .padding(.bottom, Space.small)
    }
}

struct SectionCard<Content: View>: View {
    let title: String
    let icon: String
    let content: Content

    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Space.small) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.orange)

                Text(title)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            content
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Space.medium)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

#if targetEnvironment(simulator)
    #Preview {
        AboutView()
    }
#endif
