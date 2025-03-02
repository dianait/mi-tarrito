import SwiftData
import SwiftUI

enum Mode {
    case edit
    case view
}

public struct IntroView: View {
    @State private var text = ""
    @State private var counter: Int = 0
    @FocusState private var responseIsFocussed: Bool
    var action: (String) -> Void
    @State var mode: Mode = .edit

    public var body: some View {
        NavigationStack {
            VStack(spacing: Space.extraExtraLarge) {
                TarritoView()
                    .offset(x: Space.large, y: 2)
                HeaderView()
                ZStack {
                    StickiesView(mode: $mode)

                    if mode == .edit {
                        TextEditor(text: $text)
                            .focused($responseIsFocussed)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    responseIsFocussed = true
                                }
                            }
                            .onReceive(text.publisher.last()) {
                                if ($0 as Character).asciiValue == 10 {
                                    responseIsFocussed = false
                                    text.removeLast()
                                }
                            }
                            .padding([.leading, .trailing])
                            .opacity(0.2)
                            .frame(width: 250, height: 170)
                    }
                }
                .overlay(
                    Group {
                        if mode == .edit && !text.isEmpty {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button(
                                        action: {
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                        save()
                                    }) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 44))
                                            .foregroundColor(.green)
                                            .background(Circle().fill(.white))
                                            .shadow(radius: 3)
                                    }
                                    .padding(.trailing, 20)
                                    .padding(.bottom, 20)
                                    // .modifier(FloatingEffect())
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                )
                Spacer()
            }
            .confettiCannon(counter: $counter)
            .padding()
        }
    }

    private func save() {
        if !text.isEmpty {
            action(text)
            text = ""
            counter += 1
        }
        mode = .view
    }

    private func openEdit() {
        mode = .edit
    }
}

#Preview {
    IntroView { _ in }
        .modelContainer(for: Item.self, inMemory: true)
}

struct FloatingEffect: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? -5 : 0)
            .animation(
                Animation.easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}
