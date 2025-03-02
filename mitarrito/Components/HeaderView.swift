import SwiftUI

struct HeaderView: View {
    @Binding var mode: Mode
    @Binding var text: String
    @Environment(\.screenSize) private var screenSize

    var viewTitle: String {
        screenSize.width < 380 ? "¡Es hora de celebrar!" : "¡Es hora de celebrar tus logros!"
    }

    var viewDecription: String {
        screenSize.width < 380 ? "Pulsa en la nota amarilla" : "Pulsa en la nota amarilla para empezar"
    }

    var editDescription: String {
        screenSize.width < 380 ? "Desliza hacia arriba" : "Desliza hacia arriba para guardar"
    }

    var body: some View {
        VStack {
            if mode == .edit && !text.isEmpty {
                Text("¿Has terminado?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                Text(editDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            } else {
                Text(viewTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                Text(viewDecription)
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
    }
}


extension EnvironmentValues {
    var screenSize: CGSize {
        get { self[ScreenSizeKey.self] }
        set { self[ScreenSizeKey.self] = newValue }
    }
}

struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = UIScreen.main.bounds.size
}

#Preview {
    MainView { _ in }
        .modelContainer(for: Accomplishment.self, inMemory: true)
}
