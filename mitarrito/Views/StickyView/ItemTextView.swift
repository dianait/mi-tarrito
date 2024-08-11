import SwiftUI

struct ItemTextView: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .frame(width: 200, height: 200)
            .multilineTextAlignment(.center)
    }
}
