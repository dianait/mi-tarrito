import SwiftData
import SwiftUI

enum Mode {
    case edit
    case view
}

public struct IntroView: View {
    @State private var text = ""
    @State private var counter: Int = 0
    @State var mode: Mode = .view
    var action: (String) -> Void
    @State private var showSaveIndicator = false
    @State private var showSavedMessage = false
    @State private var showAboutView = false

    public var body: some View {
        NavigationStack {
            VStack(spacing: Space.extraExtraLarge) {
                TarritoView()
                    .offset(x: Space.large, y: 2)

                if !showSavedMessage {
                    	HeaderView(mode: $mode)
                    }

                StickiesViewOverview(
                    mode: $mode,
                    text: $text,
                    counter: $counter,
                    showSaveIndicator: $showSaveIndicator,
                    showSavedMessage: $showSavedMessage,
                    action: action
                )

                Spacer()

                               // Info button at the bottom
                               Button(action: {
                                   showAboutView = true
                               }) {
                                   HStack {
                                       Image(systemName: "info.circle.fill")
                                           .foregroundColor(.white)
                                       Text("Sobre Mi Tarrito")
                                           .foregroundColor(.white)
                                           .fontWeight(.medium)
                                   }
                                   .padding()
                                   .background(Color.orange.opacity(0.8))
                                   .cornerRadius(10)
                               }
                               .padding(.bottom, Space.medium)
            }
            .savedConfirmation(isPresented: $showSavedMessage, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    showSavedMessage = false
                }
            })
            .confettiCannon(counter: $counter)
            .padding()
            .sheet(isPresented: $showAboutView) {
                AboutView()
            }
        }
    }
}

#Preview {
    IntroView { _ in }
        .modelContainer(for: Item.self, inMemory: true)
}
