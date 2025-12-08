import SwiftData
import SwiftUI
import UIKit

enum Mode {
    case edit
    case view
}

public struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @EnvironmentObject var languageManager: LanguageManager
    @State private var selectedImage: UIImage?

    var textAction: (String) -> Void
    var photoAction: (Data, String?) -> Void

    public var body: some View {
        NavigationStack {
            VStack(spacing: Space.extraLarge + Space.medium) {
                KudosJarView()

                HeaderView(mode: $viewModel.mode, text: $viewModel.text)
                    .padding(.top, Space.mediumLarge)

                StickiesViewOverview(
                    mode: $viewModel.mode,
                    text: $viewModel.text,
                    counter: $viewModel.counter,
                    showSaveIndicator: $viewModel.showSaveIndicator,
                    showSavedMessage: $viewModel.showSavedMessage,
                    dragOffset: $viewModel.dragOffset,
                    selectedPhotoData: $viewModel.selectedPhotoData,
                    onShowCamera: {
                        viewModel.showCamera = true
                    },
                    textAction: textAction,
                    photoAction: photoAction,
                    onSave: {
                        viewModel.incrementCounter()
                        viewModel.resetAllInput()
                    }
                )

                Spacer()
                HStack {
                    HStack {
                        Image(systemName: Icon.settings.rawValue)
                            .foregroundColor(.white)
                        Text(Copies.setingsTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, Space.small)
                    .padding(.horizontal, Space.medium)
                    .background(Color("PrimaryButtonBackground"))
                    .cornerRadius(CGFloat(Size.extraSmall.rawValue))
                    .accessibilityIdentifier(A11y.MainView.settingsIndentifierButton)
                    .accessibilityAddTraits(.isButton)
                    .onTapGesture {
                        viewModel.showLanguageSettings = true
                    }

                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image(systemName: Icon.info.rawValue)
                                .foregroundColor(.white)
                            Text(Copies.aboutTitle)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, Space.small)
                        .padding(.horizontal, Space.medium)
                        .background(Color("PrimaryButtonBackground"))
                        .cornerRadius(CGFloat(Size.extraSmall.rawValue))
                    }
                    .accessibilityLabel(A11y.MainView.aboutLabelButton)
                    .accessibilityHint(A11y.MainView.aboutHintButton)
                    .accessibilityIdentifier(A11y.MainView.aboutIndentifierButton)
                }

            }
            .savedConfirmation(isPresented: $viewModel.showSavedMessage, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + Timing.savedMessageDismissDelay) {
                    viewModel.hideSavedMessage()
                }
            })
            .confettiCannon(counter: $viewModel.counter)
            .padding(.horizontal)
            .sheet(isPresented: $viewModel.showLanguageSettings) {
                LanguageSettingsView()
                    .presentationDetents([.height(180)])
            }
            .sheet(isPresented: $viewModel.showCamera) {
                if isCameraAvailable() {
                    CameraPickerView(selectedImage: $selectedImage)
                } else {
                    Text(Copies.Camera.notAvailable)
                        .padding()
                }
            }
            .onChange(of: selectedImage) { _, newImage in
                if let image = newImage {
                    // Compress and store the image
                    if let compressedData = compressImage(image) {
                        viewModel.selectedPhotoData = compressedData
                    }
                    selectedImage = nil
                }
            }
            .localized()
            .background(Color("MainBackground"))
        }
    }
}

// MARK: - Camera Helpers

/// Checks if the camera is available on this device
private func isCameraAvailable() -> Bool {
    UIImagePickerController.isSourceTypeAvailable(.camera)
}

/// Compresses an image to reduce storage size
/// - Parameters:
///   - image: The UIImage to compress
///   - maxSizeKB: Maximum size in kilobytes (default 500KB)
/// - Returns: Compressed image data, or nil if compression fails
private func compressImage(_ image: UIImage, maxSizeKB: Int = 500) -> Data? {
    let maxBytes = maxSizeKB * 1024
    var compression: CGFloat = 1.0
    let step: CGFloat = 0.1

    // Start with JPEG compression
    guard var imageData = image.jpegData(compressionQuality: compression) else {
        return nil
    }

    // Reduce quality until we're under the size limit
    while imageData.count > maxBytes && compression > step {
        compression -= step
        if let newData = image.jpegData(compressionQuality: compression) {
            imageData = newData
        }
    }

    // If still too large, resize the image
    if imageData.count > maxBytes {
        let scale = sqrt(Double(maxBytes) / Double(imageData.count))
        let newSize = CGSize(
            width: image.size.width * scale,
            height: image.size.height * scale
        )

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let resized = resizedImage {
            imageData = resized.jpegData(compressionQuality: 0.8) ?? imageData
        }
    }

    return imageData
}

// MARK: - Camera Picker View

/// A view that presents the camera to take a photo
struct CameraPickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPickerView

        init(_ parent: CameraPickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // Prefer edited image, fall back to original
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#if targetEnvironment(simulator)
    #Preview {
        MainView(textAction: { _ in }, photoAction: { _, _ in })
            .environmentObject(LanguageManager.shared)
            .preferredColorScheme(.dark)
    }
#endif
