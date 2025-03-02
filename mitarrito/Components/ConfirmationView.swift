import SwiftUI

struct ConfirmationView: View {
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)? = nil
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack(alignment: .top) {
                    VStack(alignment: .center, spacing: 12) {
                        Spacer().frame(height: 25)

                        Text(Copies.ConfirmationView.title)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text(Copies.ConfirmationView.description)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(reduceTransparency ? 1.0 : 0.9))

                        Button(action: {
                            withAnimation(reduceMotion ? .none : .default) {
                                isPresented = false
                                onDismiss?()
                            }
                        }) {
                            Text(Copies.ConfirmationView.button)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 8)
                                .background(Capsule().fill(Color.white))
                        }
                        .padding(.top, 10)
                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 40)
                    .frame(width: UIScreen.main.bounds.width * 0.85)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.green)
                    )
                    .shadow(color: reduceTransparency ? .clear : Color.black.opacity(0.1),
                            radius: 8, x: 0, y: 5)

                    HStack(spacing: -10) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 70, height: 70)
                                .shadow(color: reduceTransparency ? .clear : Color.black.opacity(0.1),
                                        radius: 2, x: 0, y: 1)
                                .accessibilityHidden(true)

                            Image(systemName: "checkmark")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.green)
                                .accessibilityHidden(true)
                        }
                    }
                    .offset(y: -25)
                    .accessibilityHidden(true)
                }
                .accessibilityElement()
                .accessibilityLabel(A11y.ConfirmationView.label)
                .accessibilityHint(A11y.ConfirmationView.hint)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        }
        .transition(.asymmetric(
            insertion: reduceMotion ? .opacity : .scale.combined(with: .opacity),
            removal: .opacity
        ))
        .animation(reduceMotion ? .none : .spring(), value: isPresented)
        .zIndex(100)
        .onAppear {
            UIAccessibility.post(
                notification: .announcement,
                argument: A11y.ConfirmationView.noti
            )

            if UIAccessibility.isVoiceOverRunning {
                DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                    if isPresented {
                        isPresented = false
                        onDismiss?()
                    }
                }
            }
        }
    }
}

extension View {
    func savedConfirmation(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil) -> some View {
        ZStack {
            self

            if isPresented.wrappedValue {
                ConfirmationView(isPresented: isPresented, onDismiss: onDismiss)
            }
        }
    }
}

#Preview {
    Color.gray.opacity(0.3)
        .savedConfirmation(isPresented: .constant(true))
}
