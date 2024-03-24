import SwiftUI

struct Tarrito3DView: View {
    var body: some View {
        VStack {
            GeometryReader { viewGeometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    GeometryReader { imageGeometry in
                        Image(.tarrrito)
                            .frame(width: 300, height: 300)
                            .padding(15)
                            .rotation3DEffect(.degrees(Double(imageGeometry.frame(in: .global).midX - viewGeometry.size.width / 2)),
                                              axis: (x: 0, y: 1, z: 0))
                    }
                }
            }
        }
    }
}

#Preview {
    Tarrito3DView()
}
