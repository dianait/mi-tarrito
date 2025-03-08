import SwiftUI

struct DateLabelView: View {
    var date: Date

    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }

    var body: some View {
        HStack {
            Spacer()
            Text(formatter.string(from: date))
                .font(.caption)
                .padding(.vertical, Space.small)
                .padding(.horizontal, Space.medium)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                .overlay(Capsule().stroke(Color.white, lineWidth: 2))
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    DateLabelView(date: Date())
        .padding()
        .border(.red)
}
#endif
