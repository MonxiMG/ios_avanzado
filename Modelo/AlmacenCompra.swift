import Foundation

final class AlmacenCompra {
    static let shared = AlmacenCompra()

    private let key = "lista_compra_items"

    private(set) var items: [ItemCompra] = []

    private init() {
        cargar()
    }

    private func cargar() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            items = []
            return
        }
        items = (try? JSONDecoder().decode([ItemCompra].self, from: data)) ?? []
    }

    private func guardar() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func añadir(nombre: String, cantidad: String, recetaTitulo: String) {
        let nuevo = ItemCompra(nombre: nombre, cantidad: cantidad, recetaTitulo: recetaTitulo, comprado: false)
        items.append(nuevo)
        guardar()
    }

    func toggleComprado(id: UUID) {
        guard let i = items.firstIndex(where: { $0.id == id }) else { return }
        items[i].comprado.toggle()
        guardar()
    }

    func eliminar(id: UUID) {
        items.removeAll { $0.id == id }
        guardar()
    }

    func vaciar() {
        items.removeAll()
        guardar()
    }
}

