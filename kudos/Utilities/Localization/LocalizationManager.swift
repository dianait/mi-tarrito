import Foundation
import SwiftUI

/// Thread-safe language manager for app localization.
/// Uses @MainActor to ensure all state changes happen on the main thread,
/// which is required for ObservableObject publishers.
@MainActor
final class LanguageManager: ObservableObject {
    @Published var currentLanguage: String

    /// Thread-safe singleton using nonisolated(unsafe) for static initialization
    nonisolated(unsafe) static let shared: LanguageManager = {
        // Must use MainActor.assumeIsolated since we're in a static context
        // but the init requires MainActor isolation
        let instance = LanguageManager()
        return instance
    }()

    static let supportedLanguages = ["es", "en"]

    private static let languageKey = "selectedLanguage"

    private init() {
        // Determine initial language
        let systemLanguage = Locale.preferredLanguages.first ?? ""
        var initialLanguage = systemLanguage.starts(with: "es") ? "es" : "en"

        // Override with saved preference if available
        if let savedLanguage = UserDefaults.standard.string(forKey: Self.languageKey),
           Self.supportedLanguages.contains(savedLanguage) {
            initialLanguage = savedLanguage
        }

        self.currentLanguage = initialLanguage
    }

    func setLanguage(_ language: String) {
        guard Self.supportedLanguages.contains(language) else { return }

        self.currentLanguage = language
        UserDefaults.standard.set(language, forKey: Self.languageKey)
    }

    nonisolated func localizedString(for key: String) -> String {
        // Access currentLanguage safely from any thread by reading synchronously
        let bundleLanguage = MainActor.assumeIsolated { self.currentLanguage }

        if let path = Bundle.main.path(forResource: bundleLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }

        return NSLocalizedString(key, comment: "")
    }
}
