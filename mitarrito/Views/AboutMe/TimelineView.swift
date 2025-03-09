import SwiftUI

struct TimelineView: View {
    private var primaryColor: Color { Color.orange }
    var body: some View {
        VStack(alignment: .leading, spacing: Space.small) {
            HStack {
                Image(systemName: Icon.book.rawValue)
                    .font(.title)
                    .foregroundColor(primaryColor)

                Text(Copies.AboutMe.Timeline.title)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(primaryColor)
            }
            .padding(.vertical, Space.large)

            LazyVStack(alignment: .leading, spacing: Space.large) {

                ForEach(Copies.AboutMe.Timeline.steps, id: \.title) { step in
                    TimelineItem(
                        icon: step.icon,
                        title: step.title,
                        description: step.description
                    )
                }
            }
        }

        .padding(.leading, Space.small)
    }
}

struct TimelineItem: View {
    let icon: String
    let title: String
    let description: String

    private let circleSize = CGFloat(Size.smallMedium.rawValue)
    private let circleBackgroundSize = CGFloat(Size.large.rawValue)
    private let iconSize = CGFloat(Size.medium.rawValue)
    private let spacing = CGFloat(Size.mediumLarge.rawValue)

    var body: some View {
        VStack(alignment: .leading, spacing: Space.small) {
            HStack(spacing: Space.small) {
                Image(systemName: icon)
                    .foregroundColor(.orange)
                    .font(.system(size: Space.large))

                Text(title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
            }

            Text(description)
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, Space.small)
        }
    }
}

#if targetEnvironment(simulator)
    #Preview {
        TimelineView()
            .padding()
    }
#endif
