import SwiftUI

struct StickyView: View {
    var item: Accomplishment
    var delete: (() -> Void)? = nil

    var isEditMode: Bool {
        delete != nil
    }

    var widthOffset: CGFloat {
        isEditMode ? .zero : -CGFloat(Size.extraLarge.rawValue)
    }

    var heightOffset: CGFloat {
        isEditMode ?
            -CGFloat(Size.extraSmall.rawValue) :
            CGFloat(Size.mediumLarge.rawValue)
    }

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                // Show photo if available, otherwise show colored background
                if item.hasPhoto, let photoData = item.photoData, let uiImage = UIImage(data: photoData) {
                    photoBackgroundView(image: uiImage)
                } else {
                    BackgroundImageView(color: item.color)
                }

                VStack {
                    if isEditMode {
                        DeleteButtonView(action: { delete?() })
                            .offset(
                                x: -CGFloat(Size.mediumLarge.rawValue),
                                y: CGFloat(Size.mediumLarge.rawValue)
                            )
                    }

                    // Show text only if there is text content
                    if item.hasText {
                        if item.hasPhoto {
                            // Photo with caption - show text at bottom with background
                            textOverlayView
                        } else {
                            // Text only - centered
                            ItemTextView(text: item.text)
                                .multilineTextAlignment(.center)
                                .offset(x: widthOffset, y: heightOffset)
                        }
                    }

                    if isEditMode {
                        DateLabelView(date: item.date)
                            .offset(x: Dimensions.dateLabelXOffset, y: Dimensions.dateLabelYOffset)
                            .accessibilityLabel(A11y.StickyView.dateLabel(date: item.date))
                    }
                }
                .padding()
            }
        }
        .frame(width: Dimensions.stickyWidth, height: Dimensions.stickyHeight)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabelText)
    }

    // MARK: - Subviews

    @ViewBuilder
    private func photoBackgroundView(image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: Dimensions.stickyWidth, height: Dimensions.stickyHeight)
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(Size.small.rawValue)))
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
    }

    @ViewBuilder
    private var textOverlayView: some View {
        VStack {
            Spacer()
            Text(item.text)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, Space.small)
                .padding(.vertical, Space.extraSmall)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.6))
        }
    }

    // MARK: - Accessibility

    private var accessibilityLabelText: String {
        if item.hasPhoto && item.hasText {
            return "\(A11y.StickyView.photoWithCaption): \(item.text)"
        } else if item.hasPhoto {
            return A11y.StickyView.photoOnly
        } else {
            return A11y.StickyView.label
        }
    }
}

#if targetEnvironment(simulator)
    let itemMock = Accomplishment(
        validatedText: "🎉 Tu primer logro aquí",
        validatedColor: "yellow"
    )

    #Preview("👀 View Mode") {
        StickyView(item: itemMock)
    }

    #Preview("✏️ Texto largo") {
        StickyView(item: Accomplishment(
            validatedText: "🎉 Tu primer logro aquí esto es un texto muy largo que necestio de una línea para que se note el reajuste del layout",
            validatedColor: "yellow"
        )) {}
    }

    #Preview("✏️ Texto más largo") {
        StickyView(item: Accomplishment(
            validatedText: "🎉 Tu primer logro aquí esto es un texto muy largo que necestio de una línea para que se note el reajuste del layout y el texto sea todavía mas largo",
            validatedColor: "yellow"
        )) {}
    }

    #Preview("✏️ Edit Mode") {
        StickyView(item: itemMock) {}
    }
#endif
