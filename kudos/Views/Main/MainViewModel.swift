import SwiftUI

/// ViewModel for MainView that manages all state related to the main screen.
///
/// This ViewModel consolidates multiple `@State` properties into a single `@StateObject`,
/// following MVVM pattern and improving code organization and testability.
///
/// Responsibilities:
/// - Managing edit/view mode state
/// - Handling text input state
/// - Managing celebration animations (confetti counter)
/// - Controlling UI visibility (save indicators, messages, settings)
/// - Managing drag gesture offset for save interaction
@MainActor
class MainViewModel: ObservableObject {
    // MARK: - Editing State
    
    /// Current text input for the achievement being created
    @Published var text: String = ""
    
    /// Current mode: `.edit` when user is typing, `.view` when displaying
    @Published var mode: Mode = .view
    
    // MARK: - Celebration State
    
    /// Counter for confetti animation triggers (increments on each save)
    @Published var counter: Int = 0
    
    // MARK: - UI State
    
    /// Indicates when user has dragged enough to trigger save (visual feedback)
    @Published var showSaveIndicator: Bool = false
    
    /// Shows confirmation message after successful save
    @Published var showSavedMessage: Bool = false
    
    /// Controls language settings sheet visibility
    @Published var showLanguageSettings: Bool = false
    
    /// Current drag offset for save gesture (used in StickiesViewOverview)
    @Published var dragOffset: CGSize = .zero
    
    // MARK: - Actions
    
    /// Increments the celebration counter (triggers confetti animation)
    func incrementCounter() {
        counter += 1
    }
    
    /// Resets the text input field after saving
    func resetText() {
        text = ""
    }
    
    /// Resets all save-related UI state
    func resetSaveState() {
        showSaveIndicator = false
        dragOffset = .zero
    }
    
    /// Hides the saved message confirmation
    func hideSavedMessage() {
        showSavedMessage = false
    }
}
