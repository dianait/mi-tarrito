import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var currentTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            switch currentTab {
                case .home:
                    IntroView(){
                        text in
                        addItem(text: text)
                    }
                        .applyBG()
                        .tag(currentTab.rawValue)
                case .list:
                    ImageGalleryCarouselView() {
                    item in
                        removeItem(item: item)

                    }
                        .applyBG()
                        .tag(currentTab.rawValue)
            }
        }
        CustomTabbar(currentTab: $currentTab)
    }
    
    private func addItem(text: String) {
        withAnimation {
            let newItem = Item(text: text, color: ColorUtility.randomColorString())
            modelContext.insert(newItem)
        }
    }

    private func removeItem(item: Item) {
        withAnimation {
            if let item = items.first {
                modelContext.delete(item)
            }
        }
    }
}

extension View {
    func applyBG() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

struct ColorUtility {
    static let availableColors = [
        "blue",
        "cyan",
        "green",
        "indigo",
        "mint",
        "orange",
        "pink",
        "purple",
        "red",
        "teal",
        "yellow"
    ]

    static func randomColorString() -> String {
        return availableColors.randomElement() ?? "gray"
    }
}

enum Tab: String, CaseIterable {
    case home
    case list
}

struct CustomTabbar: View {
    @Binding var currentTab: Tab
    @State var yOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) {
                            currentTab = tab
                            yOffset = -60
                        }
                        
                        withAnimation(.easeOut(duration: 0.1).delay(0.07)) {
                            yOffset = 0
                        }
                    } label: {
                        Image(systemName: getImage(rawValue: tab.rawValue))
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? .orange : .gray)
                            .scaleEffect(currentTab == tab ? 1.3 : 1)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(alignment: .leading) {
                Circle()
                    .fill(.white)
                    .frame(width: 50, height: 50)
                    .offset(x: 65, y: yOffset)
                    .offset(x: indicatorOffset(width: width))
                    .shadow(color: .orange, radius: 7)
            }
        }
        .frame(height: 30)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
    }
    
    func indicatorOffset(width: CGFloat) -> CGFloat {
        let index = CGFloat(getIndex())
        if index == 0 {
            return 0
        }
        let buttonWidth = width / CGFloat(Tab.allCases.count)
        return index * buttonWidth
    }
    
    func getIndex() -> Int {
        switch currentTab {
            case .home:
                return 0
            case .list:
                return 1
        }
    }
    
    func getImage(rawValue: String) -> String {
        switch rawValue {
            case "home":
                return "house.fill"
            case "list":
                return "list.clipboard.fill"
            default:
                return ""
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
