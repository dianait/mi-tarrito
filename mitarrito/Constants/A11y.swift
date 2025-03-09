enum A11y {
    enum Tarrito {
        static let identifier = "Tarrito Button"
        static func label(count: Int) -> String {
            "Tarrito con \(count) \(count == 1 ? "logro guardado" : "logros guardados")"
        }
        static let hint = "Toca para ver tus logros en detalle"

    }

    enum StickiesView {
        static let stickie = "Main Stickie"
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
        static let view = "Confimation Pop-Up"
        static let button = "Continue Button"
    }

    enum StickiesViewOverview {
        static let editModeNotification = "Modo de edición activado. Escribe tu logro."
        static let textEditorLabel = "Editor de texto para tu logro"
        static let textEditorHint = "Editor de texto para tu logro"
        static let textEditorIdentifer = "Text Editor"
        static func charCounterLabel(count: Int, max: Int) -> String {
            "Contador de caracteres: \(count) de \(max)"
        }

        static let readyToSaveNotification = "Listo para guardar. Suelta para confirmar."
        static let saveAction = "Guardar logro"
    }
}
