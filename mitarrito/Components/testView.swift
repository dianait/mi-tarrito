import SwiftUI

struct TabBarView2111: View {
    @State var selectedTab = ""
    enum TabbedItems: String, CaseIterable {
        case home
        case list
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                IntroView()
                    .tag("home")

                ListView()
                    .tag("list")
            }

            RoundedRectangle(cornerRadius: 25)
                .frame(width: 350, height: 70)
                .foregroundColor(.white)
                .shadow(radius: 0.8)

            Button {
                selectedTab = "ticket"
            } label: {
                CustomTabItem(imageName: "ticket", title: "Ticket", isActive: selectedTab == "ticket")
            }
            .frame(width: 65, height: 65)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 0.8)
            .offset(y: -50)

            HStack {
                Button {
                    selectedTab = "home"
                } label: {
                    CustomTabItem(
                        imageName: "home",
                        title: "home",
                        isActive: selectedTab == "home"
                    )
                }
                Button {
                    selectedTab = "list"
                } label: {
                    CustomTabItem(
                        imageName: "list",
                        title: "list",
                        isActive: selectedTab == "list"
                    )
                }
            }
            .frame(height: 70)
        }
    }
}

extension TabBarView2111 {
    func CustomTabItem(imageName: String, title _: String, isActive: Bool) -> some View {
        HStack(alignment: .center, spacing: 22) {
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .purple : .gray)
                .frame(width: 25, height: 25)
            Spacer()
        }
    }
}

#Preview {
    TabBarView2111()
}
