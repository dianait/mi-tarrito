import SwiftData
import SwiftUI

// Update MainView to use the new CarouselView
struct MainView: View {
    var body: some View {
        TabView {
            CarouselView()
                .tabItem {
                    Label("Carousel", systemImage: "rectangle.stack")
                }

            TarritoView()
                .tabItem {
                    Label("Tarrito", systemImage: "star")
                }
        }
    }
}

#if targetEnvironment(simulator)
    #Preview {
        MainView { _ in }
            .environmentObject(LanguageManager.shared)
    }
#endif
