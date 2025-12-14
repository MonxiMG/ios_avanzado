import Foundation

struct Paso: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var titulo: String
    var detalle: String
    var minutos: Int?
}

