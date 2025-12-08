import SwiftData
import SwiftUI

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

#if targetEnvironment(simulator)
    #Preview {
        MainView(textAction: { _ in }, photoAction: { _, _ in })
            .environmentObject(LanguageManager.shared)
            .preferredColorScheme(.dark)
    }
#endif
