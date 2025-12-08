import SwiftData
import SwiftUI

struct AccomplishmentDetailView: View {
    let accomplishment: Accomplishment
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var languageManager: LanguageManager
    @State private var showDeleteConfirmation = false

    // Cached DateFormatter - expensive to create, so reuse
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()

    // Track which language the formatter was configured for
    private static var formatterLanguage: String = ""

    // Determine if text is long enough to show only text view
    private var isLongText: Bool {
        accomplishment.text.count > 80
    }

    private var formattedDate: String {
        let currentLanguage = languageManager.currentLanguage

        // Only reconfigure formatter if language changed
        if Self.formatterLanguage != currentLanguage {
            let localeIdentifier = currentLanguage == "es" ? "es_ES" : "en_US"
            Self.dateFormatter.locale = Locale(identifier: localeIdentifier)
            Self.formatterLanguage = currentLanguage
        }

        return Self.dateFormatter.string(from: accomplishment.date)
    }
    
    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: Space.large) {
                    if isLongText {
                        // For long text, show only the text in a readable format
                        textOnlyView
                    } else {
                        // For short text, show sticky note view
                        StickyView(item: accomplishment)
                            .scaleEffect(1.2)
                            .padding(.top, Space.extraLarge)
                    }
                    
                    // Date information
                    dateCardView
                    
                    // Delete button
                    deleteButtonView
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(Copies.AccomplishmentDetail.deleteConfirmationTitle, isPresented: $showDeleteConfirmation) {
            Button(Copies.AccomplishmentDetail.deleteCancel, role: .cancel) { }
            Button(Copies.AccomplishmentDetail.deleteConfirm, role: .destructive) {
                deleteAccomplishment()
            }
        } message: {
            Text(Copies.AccomplishmentDetail.deleteConfirmationMessage)
        }
        .localized()
    }
    
    @ViewBuilder
    private var textOnlyView: some View {
        VStack(alignment: .leading, spacing: Space.medium) {
            Text(accomplishment.text)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Space.medium)
                .fill(Color.fromString(accomplishment.color).opacity(0.3))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
        .padding(.top, Space.extraLarge)
    }
    
    @ViewBuilder
    private var dateCardView: some View {
        VStack(spacing: Space.small) {
            Image(systemName: "calendar")
                .font(.title2)
                .foregroundColor(.orange)
            
            Text(Copies.AccomplishmentDetail.dateLabel)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(formattedDate)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Space.medium)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var deleteButtonView: some View {
        Button(action: {
            showDeleteConfirmation = true
        }) {
            HStack {
                Image(systemName: Icon.trash.rawValue)
                Text(Copies.AccomplishmentDetail.deleteButton)
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(Space.small)
        }
        .padding(.horizontal)
        .padding(.bottom, Space.extraLarge)
        .accessibilityLabel(Copies.AccomplishmentDetail.deleteButton)
        .accessibilityHint(Copies.AccomplishmentDetail.deleteHint)
    }
    
    private func deleteAccomplishment() {
        withAnimation {
            modelContext.delete(accomplishment)
            dismiss()
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    NavigationStack {
        AccomplishmentDetailView(
            accomplishment: Accomplishment(
                validatedText: "🎉 Mi primer logro importante que quiero celebrar",
                validatedColor: "yellow"
            )
        )
    }
    .modelContainer(for: Accomplishment.self, inMemory: true)
}
#endif

