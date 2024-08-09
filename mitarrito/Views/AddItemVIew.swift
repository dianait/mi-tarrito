import SwiftUI

struct AddItemVIew: View {
    @State private var text = ""
    var action: (String) -> Void
    @State private var counter: Int = 0
    @FocusState private var responseIsFocussed: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            TarritoView()
            ZStack(alignment: .topTrailing) {
                Image("libreta")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                TextView(text: $text)
                    .focused($responseIsFocussed)
                    .onReceive(text.publisher.last()) {
                        if ($0 as Character).asciiValue == 10 {
                            responseIsFocussed = false
                            text.removeLast()
                        }
                    }
                    .padding([.leading, .trailing])
                    .opacity(0.2)

            }
            Button(action: {
                if !text.isEmpty {
                    action(text)
                    text = ""
                    counter += 1

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        dismiss()
                    }
                }
            }) {
                Text("💾 GUARDAR")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(text.isEmpty ? Color.gray : Color.orange)
                    .opacity(text.isEmpty ? 0.6: 1)
                    .cornerRadius(10)
            }
            .disabled(text.isEmpty)
            .padding([.leading, .trailing])
            Spacer()
        }
        .confettiCannon(counter: $counter)
        .padding()
    }
}

#Preview {
    AddItemVIew { _ in }
        .padding(.top, 5)
}

struct TextView: View {
    @Binding var text: String

    var body: some View {
        TextEditor(text: $text)
            .padding(.top, 60)
    }
}
