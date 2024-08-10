import SwiftUI
import SwiftData

public struct IntroView: View {
    @State private var text = ""
    @State private var counter: Int = 0
    @FocusState private var responseIsFocussed: Bool
    var action: (String) -> Void

    public var body: some View {
        VStack {
            TarritoView()
                .offset(x: 20, y: 40)
            Spacer()
            ZStack{
                StickiesView()
                TextEditor(text: $text)
                    .focused($responseIsFocussed)
                    .onReceive(text.publisher.last()) {
                        if ($0 as Character).asciiValue == 10 {
                            responseIsFocussed = false
                            text.removeLast()
                        }
                    }
                    .padding([.leading, .trailing])
                    .opacity(0.2)
                    .frame(width: 250, height: 170)
                /*
                 Text("Escribe aquí tu logro...")
                    .fontWeight(.light)
                    .foregroundColor(.black.opacity(0.4))
                    .padding(8)
                    .hidden(!text.isEmpty)
                 */
            }
            Spacer()
            Button(action: {
                if !text.isEmpty {
                    action(text)
                    text = ""
                    counter += 1
                }
            }) {
                Text("🎉 PA`L TARRITO")
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)

                    .background(text.isEmpty ? Color.gray : Color.orange)
                    .opacity(text.isEmpty ? 0.6: 1)
                    .cornerRadius(10)
            }
            .disabled(text.isEmpty)
            .padding([.leading, .trailing])
        }
        .confettiCannon(counter: $counter)
        .padding()
    }
}

#Preview {
    IntroView() { _ in }
        .modelContainer(for: Item.self, inMemory: true)
}

extension View {
    @ViewBuilder public func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
            case true: self.hidden()
            case false: self
        }
    }
}
