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
}
