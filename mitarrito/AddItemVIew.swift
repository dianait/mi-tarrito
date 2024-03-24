import SwiftUI

struct AddItemVIew: View {
    @State private var text = ""
    var action: (String) -> Void

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image("libreta")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                TextView(text: $text)
                    .frame(minHeight: 200)
                    .padding([.leading, .trailing])
                    .opacity(0.5)
            }

            Button(action: {
                action(text)
                text = ""
            }) {
                Text("PPT")
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
        .background(Color(UIColor.systemBackground))
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
            .cornerRadius(10)
            .padding(.horizontal, 5)
            .padding(.top, 60)
    }
}
