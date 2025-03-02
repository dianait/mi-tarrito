import Foundation

struct Copies {
    static func viewTitle(screenWidth: CGFloat) -> String {
        screenWidth < 380 ? "¡Es hora de celebrar!" : "¡Es hora de celebrar tus logros!"
    }

    static func viewDecription(screenWidth: CGFloat) -> String {
        screenWidth < 380 ? "Pulsa en la nota amarilla" : "Pulsa en la nota amarilla para empezar"
    }

    static func editDescription(screenWidth: CGFloat) -> String {
        screenWidth < 380 ? "Desliza hacia arriba" : "Desliza hacia arriba para guardar"
    }

    static let editTitle: String = "¿Has terminado?"
}
