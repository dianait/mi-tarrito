import SwiftData
import SwiftUI

struct StickiesViewOverview: View {
    @FocusState private var responseIsFocussed: Bool
    @State private var dragOffset: CGSize = .zero
    @State private var isEditModeActive: Bool = false

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
                            .accessibilityHidden(true)
                        TextEditor(text: $text)
                            .focused($responseIsFocussed)
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .font(.body)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    responseIsFocussed = true

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        UIAccessibility.post(
                                            notification: .screenChanged,
                                            argument: "Modo de edición activado. Escribe tu logro."
                                        )
                                    }

                                    isEditModeActive = true
                                }
                            }
                            .onDisappear {
                                isEditModeActive = false
                            }
                            .onReceive(text.publisher.last()) {
                                if ($0 as Character).asciiValue == 10 {
                                    responseIsFocussed = false
                                    text.removeLast()
                                }
                            }
                            .padding([.leading, .trailing])
                            .opacity(.zero)
                            .frame(width: 250, height: 170)
                            .accessibilityLabel("Editor de texto para tu logro")
                            .accessibilityHint("Escribe tu logro. Desliza hacia arriba para guardar.")
                            .accessibilityIdentifier("logro-editor")

                        Text(text.isEmpty ? "Escribe aquí..." : text)
                            .foregroundColor(text.isEmpty ? .gray : .black)
                            .opacity(1)
                            .frame(width: 250, height: 170)
                            .padding([.leading, .trailing])
                            .accessibilityHidden(true)
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

                                if dragAmount < -100, !showSaveIndicator {
                                    UIAccessibility.post(
                                        notification: .announcement,
                                        argument: "Listo para guardar. Suelta para confirmar."
                                    )
                                }
                            }
                        }
                        .onEnded { gesture in
                            if gesture.translation.height < -50, !text.isEmpty {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
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
                .accessibilityAction(named: "Guardar logro") {
                    if !text.isEmpty {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        save()
                        showSavedMessage = true
                    }
                }
            } else {
                StickiesView(mode: $mode)
            }
        }
        .onChange(of: mode) { oldValue, newValue in
            if newValue == .edit && oldValue == .view {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    responseIsFocussed = true
                }
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
