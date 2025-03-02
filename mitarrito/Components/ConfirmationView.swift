import SwiftUI

struct ConfirmationView: View {
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)? = nil

    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack(alignment: .top) {
                    VStack(alignment: .center, spacing: 12) {
                        Spacer().frame(height: 25)

                        Text("¡Logro guardado!")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Tu tarrito crece con cada logro 🎉")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.9))


                        Button(action: {
                            withAnimation {
                                isPresented = false
                                onDismiss?()
                            }
                        }) {
                            Text("Continuar")
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
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 5)
                    HStack(spacing: -10) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 70, height: 70)
                                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)

                            Image(systemName: "checkmark")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.green)
                        }
                    }
                    .offset(y: -25)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        }
        .transition(.asymmetric(
            insertion: .scale.combined(with: .opacity),
            removal: .opacity
        ))
        .animation(.spring(), value: isPresented)
        .zIndex(100)
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
