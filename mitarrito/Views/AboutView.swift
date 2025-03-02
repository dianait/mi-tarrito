import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Privacy Title
                    Text("Privacidad Total: Tu Información, Solo Tuya")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)

                    Group {
                        Text("En Mi Tarrito, tu privacidad es fundamental. Cada logro que guardes permanecerá exclusivamente en tu dispositivo.")
                            .font(.body)
                    }

                    Group {
                        PrivacyDetailRow(
                            icon: "lock.fill",
                            title: "Cero conexiones externas",
                            description: "Ningún dato sale de tu teléfono"
                        )

                        PrivacyDetailRow(
                            icon: "smartphone",
                            title: "Almacenamiento local",
                            description: "Toda tu información se guarda solo en tu dispositivo"
                        )

                        PrivacyDetailRow(
                            icon: "cloud",
                            title: "Sin servidores",
                            description: "No hay ningún servidor remoto que almacene tus recuerdos"
                        )

                        PrivacyDetailRow(
                            icon: "hand.raised.fill",
                            title: "Control total",
                            description: "Solo tú decides qué guardar y qué eliminar"
                        )
                    }

                    Group {
                        Text("💡 Un proyecto de corazón")
                            .font(.headline)
                            .foregroundColor(.black)

                        Text("Mi Tarrito nace como un proyecto personal, diseñado para ayudarte a celebrar y recordar tus logros de la manera más íntima y personal posible.")
                            .font(.body)
                    }

                    SocialLinks()
                }
                .padding()
            }
            .navigationTitle("Acerca de Mi Tarrito")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct PrivacyDetailRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 30)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    AboutView()
}
