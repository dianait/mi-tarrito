// Importing SwiftUI framework for building user interfaces
import SwiftUI

// Defining a SwiftUI View named HeaderView
struct HeaderView: View {
    // Binding variables to allow two-way data flow between parent and child views
    @Binding var mode: Mode // Represents the current mode (e.g., edit or view)
    @Binding var text: String // Represents the text content to be displayed or edited

    // Accessing environment values for screen size and dynamic type size
    @Environment(\.screenSize) private var screenSize // Provides the screen size of the device
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize // Provides the current dynamic type size for accessibility

    // Accessing a shared LanguageManager object from the environment
    @EnvironmentObject var languageManager: LanguageManager

    // Computed property to determine if the edit header should be shown
    var shouldShowEditHeader: Bool {
        mode == .edit && !text.isEmpty // True if in edit mode and text is not empty
    }

    // Computed property to determine the title based on the current mode
    var title: String {
        shouldShowEditHeader ? Copies.editTitle : Copies.viewTitle(screenWidth: screenSize.width)
    }

    // Computed property to determine the description based on the current mode
    var description: String {
        shouldShowEditHeader ? Copies.editDescription(screenWidth: screenSize.width) : Copies.viewDecription(screenWidth: screenSize.width)
    }

    // The body of the HeaderView, defining its UI layout and behavior
    var body: some View {
        VStack {
            // Displaying the title with specific font and color styling
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.orange)
                .multilineTextAlignment(.center)
            
            // Displaying the description with specific font and color styling
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        // Combining accessibility elements for better screen reader support
        .accessibilityElement(children: .combine)
        .padding()
        // Adding a background with rounded corners and a border
        .background(
            RoundedRectangle(cornerRadius: Space.small)
                .fill(Color.yellow.opacity(0.2)) // Light yellow background
                .overlay(
                    RoundedRectangle(cornerRadius: CGFloat(Size.small.rawValue))
                        .stroke(Color.orange.opacity(0.5), lineWidth: 2) // Orange border
                )
        )
        // Ensuring the view resizes properly and supports accessibility features
        .fixedSize(horizontal: false, vertical: true)
        .lineLimit(dynamicTypeSize.isAccessibilitySize ? 3 : nil) // Limit lines for accessibility sizes
        .minimumScaleFactor(0.7) // Scale down text if needed
        .localized() // Apply localization to the view
    }
}

// Preview configurations for testing the HeaderView in different modes
#if targetEnvironment(simulator)
    // Preview for edit mode
    #Preview("✏️ Edit Mode") {
        HeaderView(mode: .constant(.edit), text: .constant(""))
            .environmentObject(LanguageManager.shared)
    }

    // Preview for view mode
    #Preview("👀 View Mode") {
        HeaderView(mode: .constant(.view), text: .constant(""))
            .environmentObject(LanguageManager.shared)
    }
#endif
