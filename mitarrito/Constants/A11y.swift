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
        static let aboutIndentifierButton = "About me Button"
        static let titleIdentifier = "About me Title"
    }

    enum ConfirmationView {
        static let label = "Confirmación: Logro guardado"
        static let hint = "Tu tarrito crece con cada logro"
        static let noti = "Logro guardado. Tu tarrito crece con cada logro."
    }

    enum StickiesViewOverview {
        static let editModeNotification = "Modo de edición activado. Escribe tu logro."
        static let textEditorLabel = "Editor de texto para tu logro"
        static let textEditorHint = "Editor de texto para tu logro"
        static let textEditorIdentifer = "logro-editor"
        static func charCounterLabel(count: Int, max: Int) -> String {
            "Contador de caracteres: \(count) de \(max)"
        }

        static let readyToSaveNotification = "Listo para guardar. Suelta para confirmar."
        static let saveAction = "Guardar logro"
    }
}
