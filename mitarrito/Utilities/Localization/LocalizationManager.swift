import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    @Published var currentLanguage: String

    static let shared: LanguageManager = {
        let instance = LanguageManager()
        return instance
    }()

    static let supportedLanguages = ["es", "en"]

    private init() {
        let systemLanguage = Locale.preferredLanguages.first ?? ""
        if systemLanguage.starts(with: "es") {
            self.currentLanguage = "es"
        } else {
            self.currentLanguage = "en"
        }

        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
            self.currentLanguage = savedLanguage
        }
    }

    func setLanguage(_ language: String) {
        print("Cambiando idioma a: \(language)")
        guard LanguageManager.supportedLanguages.contains(language) else { return }

        self.currentLanguage = language
        UserDefaults.standard.set(language, forKey: "selectedLanguage")
        UserDefaults.standard.synchronize()
    }

    func localizedString(for key: String) -> String {
        let bundleLanguage = currentLanguage == "es" ? "es" : "en"

        if let path = Bundle.main.path(forResource: bundleLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }

        return NSLocalizedString(key, comment: "")
    }
}
