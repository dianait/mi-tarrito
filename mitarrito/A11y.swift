enum A11y {
    enum Tarrito {
        static func label(count: Int) -> String {
            "Tarrito con \(count) \(count == 1 ? "logro guardado" : "logros guardados")"
        }

        static var hint = "Toca para ver tus logros en detalle"
    }

    enum StickiesView {
        static let hint = "Toca para crear tu primer logro"
        static func label(lastMessage: String) -> String {
            lastMessage.isEmpty ? "Escribe aquí..." : lastMessage
        }
    }

    enum MainView {
        static let aboutLabelButton = "Información sobre Mi Tarrito"
        static let aboutHintButton = "Muestra una ventana con información adicional sobre la aplicación"
    }

    enum ConfirmationView {
        static let label = "Confirmación: Logro guardado"
        static let hint = "Tu tarrito crece con cada logro"
        static let noti = "Logro guardado. Tu tarrito crece con cada logro."
    }
}
