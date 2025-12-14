import Foundation

struct ItemCompra: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var nombre: String
    var cantidad: String
    var recetaTitulo: String
    var comprado: Bool
}

