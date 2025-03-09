import SwiftUI

struct DeleteButtonView: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Image(systemName: Icon.trash.rawValue)
                    .foregroundColor(.white)
                    .padding(CGFloat(Size.extraExtraSmall.rawValue))
                    .background(Color.red)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
        }
    }
}

#Preview {
    DeleteButtonView() {}
        .padding()
        .border(.red)
}
