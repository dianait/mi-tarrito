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
            }
            .savedConfirmation(isPresented: $showSavedMessage, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                	showSavedMessage = false
                }
            })
            .confettiCannon(counter: $counter)
            .padding()
        }
    }
}

#Preview {
    IntroView { _ in }
        .modelContainer(for: Item.self, inMemory: true)
}
