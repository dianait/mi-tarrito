import Foundation
import SwiftData

/// Represents a user achievement stored as a sticky note.
/// 
/// Each accomplishment contains:
/// - Text content (validated, max 140 characters)
/// - Color (one of the predefined palette colors)
/// - Creation date (automatically set)
///
/// The model validates data on initialization to ensure data integrity.
@Model
final class Accomplishment {
    var date: Date
    var text: String
    var color: String

    /// Initializes a new Accomplishment with validation.
    ///
    /// - Parameters:
    ///   - text: The achievement text (will be trimmed and validated)
    ///   - color: The color string (defaults to random color if not provided)
    /// - Throws: `ValidationError` if text is empty or too long
    init(_ text: String, color: String = AccomplishmentColor.randomColorString()) throws {
        // Validate text (empty check, length check, trim whitespace)
        let textResult = AccomplishmentValidator.validateText(text)
        guard case .success(let validatedText) = textResult else {
            // Extract the error from the Result using pattern matching
            if case .failure(let error) = textResult {
                throw error
            }
            // Fallback (should never happen, but compiler requires it)
            throw ValidationError.emptyText
        }
        
        // Color is not validated as it always comes from the predefined palette
        self.date = Date()
        self.text = validatedText
        self.color = color
    }
    
    /// Convenience initializer for pre-validated data.
    ///
    /// Use this initializer only when you're certain the data is already validated.
    /// This is useful for previews, mocks, and cases where validation has already occurred.
    ///
    /// - Parameters:
    ///   - validatedText: Pre-validated text (should be trimmed and within length limits)
    ///   - validatedColor: Pre-validated color (should be a valid color string)
    init(validatedText: String, validatedColor: String) {
        self.date = Date()
        self.text = validatedText
        self.color = validatedColor
    }
}
