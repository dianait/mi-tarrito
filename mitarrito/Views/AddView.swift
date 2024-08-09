import SwiftUI

struct AddView: View {
    var body: some View {
        ZStack {
            StickiesView()
            AddButtonView()
                .offset(x: 0, y: 80)
        }
    }
}

#Preview {
    AddView()
}
