import SwiftUI

struct AddButtonView: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(20)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
            }
        }
    }
}

#Preview {
    AddButtonView()
}
