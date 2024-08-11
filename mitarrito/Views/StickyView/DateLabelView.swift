import SwiftUI

struct DateLabelView: View {
    var date: Date
    
    var body: some View {
        HStack {
            Spacer()
            Text(date, style: .date)
                .font(.caption)
                .padding(6)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                .overlay(Capsule().stroke(Color.white, lineWidth: 2))
        }
    }
}

#Preview {
    DateLabelView(date: Date())
        .padding()
        .border(.red)
}
