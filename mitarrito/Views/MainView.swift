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
    var action: (String) -> Void
    @State private var showSaveIndicator = false
    @State private var showSavedMessage = false
    @State private var showAboutView = false

    public var body: some View {
        NavigationStack {
            VStack(spacing: Space.extraLarge) {
                TarritoView()

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

                Button(action: {
                    showAboutView = true
                }) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.white)
                        Text("Sobre Mi Tarrito")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, Space.small)
                    .padding(.horizontal, Space.medium)
                    .background(Color.orange.opacity(0.8))
                    .cornerRadius(10)
                }
            }
            .savedConfirmation(isPresented: $showSavedMessage, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    showSavedMessage = false
                }
            })
            .confettiCannon(counter: $counter)
            .padding(.horizontal)
            .sheet(isPresented: $showAboutView) {
                AboutView()
            }
        }
    }
}
