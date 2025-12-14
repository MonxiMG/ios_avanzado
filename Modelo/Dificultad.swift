import Foundation

enum Dificultad: String, Codable, CaseIterable {
    case facil, media, dificil

    var titulo: String {
        switch self {
        case .facil: return "Fácil"
        case .media: return "Media"
        case .dificil: return "Difícil"
        }
    }
}

