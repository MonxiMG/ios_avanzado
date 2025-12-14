import Foundation

final class AlmacenRecetas {
    static let shared = AlmacenRecetas()
    private static let idTortilla = UUID(uuidString: "11111111-1111-1111-1111-111111111111")!
    private static let idPasta    = UUID(uuidString: "22222222-2222-2222-2222-222222222222")!
    private static let idEnsalada = UUID(uuidString: "33333333-3333-3333-3333-333333333333")!
    
    
    private let favoritosKey = "favoritos_recetas_ids"
    
    
    private(set) var recetas: [Receta] = [
        Receta(
            id: AlmacenRecetas.idTortilla,
            titulo: "Tortilla francesa",
            resumen: "Rápida y básica, perfecta para empezar.",
            tiempoMinutos: 7,
            dificultad: .facil,
            esFavorita: false,
            etiquetas: ["huevo", "rápido"],
            ingredientes: [
                Ingrediente(nombre: "Huevos", cantidad: "2 uds"),
                Ingrediente(nombre: "Sal", cantidad: "1 pizca")
            ],
            pasos: [
                Paso(titulo: "Batir", detalle: "Bate los huevos con sal.", minutos: 1),
                Paso(titulo: "Cuajar", detalle: "Cuaja en la sartén por ambos lados.", minutos: 5)
            ]
        ),
        Receta(
            id: AlmacenRecetas.idPasta,
            titulo: "Pasta al ajo",
            resumen: "Pasta sencilla con ajo y aceite.",
            tiempoMinutos: 15,
            dificultad: .media,
            esFavorita: true,
            etiquetas: ["pasta"],
            ingredientes: [
                Ingrediente(nombre: "Espaguetis", cantidad: "200 g"),
                Ingrediente(nombre: "Ajo", cantidad: "2 dientes"),
                Ingrediente(nombre: "Aceite de oliva", cantidad: "2 cdas")
            ],
            pasos: [
                Paso(titulo: "Cocer", detalle: "Cuece la pasta al dente.", minutos: 10),
                Paso(titulo: "Saltear", detalle: "Dora el ajo y mezcla con la pasta.", minutos: 4)
            ]
        ),
        Receta(
            id: AlmacenRecetas.idEnsalada,
            titulo: "Ensalada mixta",
            resumen: "Ligera y adaptable a lo que tengas.",
            tiempoMinutos: 10,
            dificultad: .facil,
            esFavorita: false,
            etiquetas: ["saludable"],
            ingredientes: [
                Ingrediente(nombre: "Lechuga", cantidad: "1/2"),
                Ingrediente(nombre: "Tomate", cantidad: "1 ud"),
                Ingrediente(nombre: "Atún", cantidad: "1 lata")
            ],
            pasos: [
                Paso(titulo: "Cortar", detalle: "Lava y corta los ingredientes.", minutos: 6),
                Paso(titulo: "Aliñar", detalle: "Aliña al gusto y mezcla.", minutos: 2)
            ]
        )
    ]
    
    private init() {
        aplicarFavoritos()
    }
    private func cargarFavoritos() -> Set<UUID> {
        let arr = UserDefaults.standard.stringArray(forKey: favoritosKey) ?? []
        return Set(arr.compactMap { UUID(uuidString: $0) })
    }
    
    private func guardarFavoritos(_ set: Set<UUID>) {
        let arr = set.map { $0.uuidString }
        UserDefaults.standard.set(arr, forKey: favoritosKey)
    }
    
    private func aplicarFavoritos() {
        let favs = cargarFavoritos()
        recetas = recetas.map { r in
            var copia = r
            copia.esFavorita = favs.contains(r.id)
            return copia
        }
    }
    
    func toggleFavorito(id: UUID) {
        var favs = cargarFavoritos()
        
        if favs.contains(id) { favs.remove(id) }
        else { favs.insert(id) }
        
        guardarFavoritos(favs)
        aplicarFavoritos()
    }
    


}

