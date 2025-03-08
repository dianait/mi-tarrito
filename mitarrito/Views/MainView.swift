import SwiftData
import SwiftUI

enum Mode {
    case edit
    case view
}

public struct MainView: View {
    @State private var text = ""
    @State private var counter: Int = 0
    @State var mode: Mode = .view
    @State private var showSaveIndicator = false
    @State private var showSavedMessage = false
    var action: (String) -> Void

    public var body: some View {
        NavigationStack {
            VStack(spacing: Space.extraLarge) {
                TarritoView()

                Spacer()
                    .frame(height: Space.extraLarge)

                HeaderView(mode: $mode, text: $text)

                StickiesViewOverview(
                    mode: $mode,
                    text: $text,
                    counter: $counter,
                    showSaveIndicator: $showSaveIndicator,
                    showSavedMessage: $showSavedMessage,
                    action: action
                )

                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.white)
                        Text(Copies.aboutTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, Space.small)
                    .padding(.horizontal, Space.medium)
                    .background(Color.orange.opacity(0.8))
                    .cornerRadius(10)
                    .accessibilityLabel(A11y.MainView.aboutLabelButton)
                    .accessibilityHint(A11y.MainView.aboutHintButton)
                }
            }
            .savedConfirmation(isPresented: $showSavedMessage, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    showSavedMessage = false
                }
            })
            .confettiCannon(counter: $counter)
            .padding(.horizontal)
        }
    }
}
