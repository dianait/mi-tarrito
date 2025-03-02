import SwiftUI
import SwiftData

struct StickiesViewOverview: View {
    @FocusState private var responseIsFocussed: Bool
    @State private var dragOffset: CGSize = .zero

    @Binding var mode: Mode
    @Binding var text: String
    @Binding var counter: Int
    @Binding var showSaveIndicator: Bool
    @Binding var showSavedMessage: Bool
    
    var action: (String) -> Void

    var body: some View {
        ZStack {
            if mode == .edit {
                VStack {
                    ZStack {
                        StickiesView(mode: $mode)
                        TextEditor(text: $text)
                            .focused($responseIsFocussed)
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .font(.body)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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
                            .opacity(0)
                            .frame(width: 250, height: 170)

                        // Texto con opacidad completa
                        Text(text.isEmpty ? "Escribe aquí..." : text)
                            .foregroundColor(.black)
                            .opacity(1)
                            .frame(width: 250, height: 170)
                            .padding([.leading, .trailing])
                    }
                }
                .offset(dragOffset)
                .gesture(
                    DragGesture(minimumDistance: 10)
                        .onChanged { gesture in
                            if !text.isEmpty {
                                let dragAmount = gesture.translation.height
                                let dampedAmount = min(0, dragAmount * 0.8)
                                dragOffset = CGSize(width: 0, height: dampedAmount)
                                showSaveIndicator = dragAmount < -100
                            }
                        }
                        .onEnded { gesture in
                            if gesture.translation.height < -50, !text.isEmpty {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)
                                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                                    dragOffset = CGSize(width: 0, height: -300)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    save()
                                    withAnimation {
                                        showSavedMessage = true
                                        dragOffset = .zero
                                        showSaveIndicator = false
                                    }
                                }
                            } else {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    dragOffset = .zero
                                    showSaveIndicator = false
                                }
                            }
                        }
                )
            } else {
                StickiesView(mode: $mode)
            }
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
}
