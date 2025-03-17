import SwiftUI

struct LanguageSettingsView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("select_language".localized)
                .font(.headline)
                .padding(.top)

            HStack(spacing: 30) {
                Button(action: {
                    languageManager.setLanguage("es")
                    dismiss()
                }) {
                    VStack {
                        Text("🇪🇸")
                            .font(.system(size: 40))
                        Text("Español")
                            .foregroundColor(languageManager.currentLanguage == "es" ? .blue : .primary)
                            .fontWeight(languageManager.currentLanguage == "es" ? .bold : .regular)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(languageManager.currentLanguage == "es" ? Color.blue.opacity(0.1) : Color.clear)
                    )
                }

                Button(action: {
                    languageManager.setLanguage("en")
                    dismiss()

                }) {
                    VStack {
                        Text("🇬🇧")
                            .font(.system(size: 40))
                        Text("English")
                            .foregroundColor(languageManager.currentLanguage == "en" ? .blue : .primary)
                            .fontWeight(languageManager.currentLanguage == "en" ? .bold : .regular)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(languageManager.currentLanguage == "en" ? Color.blue.opacity(0.1) : Color.clear)
                    )
                }
            }
            .padding()
        }
        .padding()
        .localized()
    }
}

#Preview {
    LanguageSettingsView()
        .environmentObject(LanguageManager.shared)
}
