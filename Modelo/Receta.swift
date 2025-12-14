import Foundation

struct Receta: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var titulo: String
    var resumen: String
    var tiempoMinutos: Int
    var dificultad: Dificultad
    var esFavorita: Bool
    var etiquetas: [String]
    var ingredientes: [Ingrediente]
    var pasos: [Paso]
}

extension Receta {
    var textoTiempo: String { "\(tiempoMinutos) min" }
}

