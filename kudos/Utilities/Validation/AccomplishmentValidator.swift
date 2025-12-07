import Foundation

/// Centralized validator for Accomplishment data.
///
/// This validator ensures data integrity by checking:
/// - Text is not empty (after trimming whitespace)
/// - Text length doesn't exceed maximum (140 characters)
///
/// Note: Color validation is not performed as colors always come from the predefined palette.
/// All validation errors are localized and can be displayed to users.
struct AccomplishmentValidator {
    static let minTextLength = 1
    static let maxTextLength = Limits.maxCharacters
    
    /// Validates achievement text content.
    ///
    /// Performs the following checks:
    /// 1. Trims leading/trailing whitespace and newlines
    /// 2. Ensures text is not empty after trimming
    /// 3. Ensures text doesn't exceed maximum character limit
    ///
    /// - Parameter text: The text to validate
    /// - Returns: `.success(String)` with trimmed text, or `.failure(ValidationError)` if invalid
    static func validateText(_ text: String) -> Result<String, ValidationError> {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedText.isEmpty else {
            return .failure(.emptyText)
        }
        
        guard trimmedText.count <= maxTextLength else {
            return .failure(.textTooLong(maxLength: maxTextLength))
        }
        
        return .success(trimmedText)
    }
}
