import SwiftData
import SwiftUI

struct StickiesViewOverview: View {
    @FocusState private var responseIsFocussed: Bool
    @State private var dragOffset: CGSize = .zero
    @State private var isEditModeActive: Bool = false
    @State private var characterCount: Int = 0
    @State private var maxCharacters: Int = 140

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
                        VStack {
                            TextEditor(text: $text)
                                .focused($responseIsFocussed)
                                .background(Color.clear)
                                .foregroundColor(.black)
                                .font(.body)
                                .onChange(of: text) { _, newValue in
                                    characterCount = newValue.count

                                    if newValue.count > maxCharacters {
                                        text = String(newValue.prefix(maxCharacters))
                                        characterCount = maxCharacters
                                    }
                                }
                                .onAppear {
                                    characterCount = text.count
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        responseIsFocussed = true

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            UIAccessibility.post(
                                                notification: .screenChanged,
                                                argument: A11y.StickiesViewOverview.editModeNotification
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
                                        characterCount = text.count
                                    }
                                }
                                .padding([.leading, .trailing])
                                .opacity(.zero)
                                .frame(width: 220, height: 150)
                                .accessibilityLabel(A11y.StickiesViewOverview.textEditorLabel)
                                .accessibilityHint(A11y.StickiesViewOverview.textEditorHint)
                                .accessibilityIdentifier(A11y.StickiesViewOverview.textEditorIdentifer)

                            Text("\(characterCount)/\(maxCharacters)")
                                .font(.caption)
                                .foregroundColor(characterCount > maxCharacters ? .red : .gray)
                                .frame(width: 250, alignment: .trailing)
                                .padding(.trailing)
                                .accessibilityLabel(
                                    A11y.StickiesViewOverview.charCounterLabel(
                                        count: characterCount,
                                        max: maxCharacters
                                    )
                                )
                        }

                        Text(text.isEmpty ? Copies.StickiesViewOverView.textEditorPlaceHolder : text)
                            .foregroundColor(text.isEmpty ? .gray : .black)
                            .opacity(1)
                            .frame(width: 250, height: 150)
                            .padding([.leading, .trailing])
                            .accessibilityHidden(true)
                    }
                }
                .offset(dragOffset)
                .gesture(
                    DragGesture(minimumDistance: CGFloat(Size.extraSmall.rawValue))
                        .onChanged { gesture in
                            if !text.isEmpty {
                                let dragAmount = gesture.translation.height
                                let dampedAmount = min(0, dragAmount * 0.8)
                                dragOffset = CGSize(width: 0, height: dampedAmount)
                                showSaveIndicator = dragAmount < -100

                                if dragAmount < -100, !showSaveIndicator {
                                    UIAccessibility.post(
                                        notification: .announcement,
                                        argument: A11y.StickiesViewOverview.readyToSaveNotification
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
                .accessibilityAction(named: A11y.StickiesViewOverview.saveAction) {
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
            characterCount = 0
        }
        mode = .view
    }
}
