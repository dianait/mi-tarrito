import SwiftUI

struct AddItemVIew: View {
    @State private var text = ""
    var action: (String) -> Void
    @State private var counter: Int = 0
    @FocusState private var responseIsFocussed: Bool
    var body: some View {
        VStack {
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
                    .frame(minHeight: 200)
                    .padding([.leading, .trailing])
                    .opacity(0.2)
            }
            .confettiCannon(counter: $counter)

            Button(action: {
                if !text.isEmpty {
                    action(text)
                    text = ""
                    counter += 1
                }
            }) {
                Text("💾 GUARDAR")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding([.leading, .trailing])
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
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
