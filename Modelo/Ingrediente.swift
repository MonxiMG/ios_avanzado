import Foundation

struct Ingrediente: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var nombre: String
    var cantidad: String
}

