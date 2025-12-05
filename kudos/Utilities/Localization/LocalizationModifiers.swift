import SwiftUI

struct LocalizationViewModifier: ViewModifier {
    @EnvironmentObject var languageManager: LanguageManager

    func body(content: Content) -> some View {
        content
            .id(languageManager.currentLanguage)
    }
}

extension View {
    func localized() -> some View {
        self.modifier(LocalizationViewModifier())
    }
}
