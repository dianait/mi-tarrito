import SwiftUI

struct ErrorView: View {
    let error: Error?
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack(spacing: Space.large) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text(Copies.ErrorView.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            if let error = error {
                VStack(spacing: Space.small) {
                    Text(Copies.ErrorView.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Text(error.localizedDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
            } else {
                Text(Copies.ErrorView.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Text(Copies.ErrorView.message)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color("MainBackground"))
        .localized()
    }
}

#if targetEnvironment(simulator)
#Preview {
    ErrorView(error: NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error message"]))
        .environmentObject(LanguageManager.shared)
}
#endif
