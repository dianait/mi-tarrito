import Foundation
import SwiftUI

enum Copies {
    private static let minScreenWidth = CGFloat(380)
    static func viewTitle(screenWidth: CGFloat) -> String {
        screenWidth < minScreenWidth ? "¡Es hora de celebrar!" : "¡Es hora de celebrar tus logros!"
    }

    static func viewDecription(screenWidth: CGFloat) -> String {
        screenWidth < minScreenWidth ? "Pulsa en la nota amarilla" : "Pulsa en la nota amarilla para empezar"
    }

    static func editDescription(screenWidth: CGFloat) -> String {
        screenWidth < minScreenWidth ? "Desliza hacia arriba" : "Desliza hacia arriba para guardar"
    }

    static let editTitle = "¿Has terminado?"
    static let aboutTitle = "Sobre Mi Tarrito"

    enum ConfirmationView {
        static let title = "¡Logro guardado!"
        static let description = "Tu tarrito crece con cada logro 🎉"
        static let button = "Continuar"
    }

    enum StickisView {
        static let accomplishmentExample1 = "🎉 Tu primer logro aquí"
        static let accomplishmentExample2 = "Otro más!"
        static let accomplishmentExample3 = "Otro y otro"
    }

    enum StickiesViewOverView {
        static let textEditorPlaceHolder = "Escribe aquí..."
    }

    enum Colors: String, CaseIterable {
        case orange
        case yellow
        case green
        case blue
    }

    enum Carrusel {
        enum EmptyState {
            static let title = "¡Guarda tus logros!"
            static let description = "Desbloquea todo tu potencial dándole valor a tus objetivos alcanzados"
            static let benefit1 = "Aumenta tu motivación diaria"
            static let benefit2 = "Mejora continua y medible"
            static let benefit3 = "Celebra tus victorias personales"
            static let addNewButton = "Añadir nuevo logro"
        }
    }

    enum AboutMe {
        static let title = "🫙 Mi Tarrito"
        static let description = "Un espacio para guardar tus logros"

        enum Privacy {
            static let title = "Tu privacidad lo primero"
            static let description = "Cada logro que guardes permanecerá exclusivamente en tu dispositivo. Tus datos nunca abandonan tu teléfono."
        }

        enum Timeline {
            static let title = "Un poco de historia..."

            private enum Step1 {
                static let title = "Todo empezó en la LicorcaConf"
                static let description =
                    "En una charla sobre el síndrome del Impostor, Silvia comentó que tenía una carpeta donde guardaba las cosas buenas que le pasaban en el trabajo."
            }

            private enum Step2 {
                static let title = "Me compré un tarrito físico"
                static let description =
                    "Y empecé a llenarlo de notas con cosas que me hacían sentirme bien en el trabajo. Una manera práctica de recordar mis logros."
            }

            private enum Step3 {
                static let title = "Lo compartí en twitter"
                static let description =
                    "Y el resto es historia... Mi tarrito se hizo famoso, se hablo de él en el AntiEvent, TechFest, y Software Crafters de Barcelona. Gracias Silvia, Ari y Jordi 🫶"
            }

            private enum Step4 {
                static let title = "Y esta es la versión digital"
                static let description =
                    "Quería publicar una app desde hace mucho tiempo, y aquí estamos. ¡Para que todos puedan tener su propio tarrito de logros!"
            }

            static let steps: [(title: String, description: String, icon: String)] = [
                (Step1.title, Step1.description, "lightbulb.fill"),
                (Step2.title, Step2.description, "brain.head.profile"),
                (Step3.title, Step3.description, "bird.fill"),
                (Step4.title, Step4.description, "iphone.gen3"),
            ]
        }

        enum Footer {
            static let title = "Desarrollado con ❤️ por @Dianait"
            static let socialLinks = "Puedes encontrarme en:"
        }
    }
}
