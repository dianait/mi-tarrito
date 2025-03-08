import SwiftUI

struct SocialLinks: View {
    var body: some View {
        VStack {
            Text("Desarrollado con ❤️ por @Dianait")
                .font(.caption)
            Text("Puedes encontrarme en:")
                .font(.footnote)
                .foregroundColor(.gray)

            HStack(spacing: Space.large) {
                ForEach(socialLinks, id: \.name) { link in
                    Button(action: {
                        UIApplication.shared.open(link.url)
                    }) {
                        VStack {
                            Image(link.iconName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: Space.large, height: Space.large)

                            Text(link.name)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(Space.small)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top)
    }
}

#Preview {
    SocialLinks()
}
