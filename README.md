# CocinarEnCasa 

App universal iOS para gestionar recetas de cocina, ver ingredientes y pasos, marcar favoritos y crear una lista de compra persistente. Diseñada con UIKit y adaptada a tamaños compact/regular (iPhone/iPad).

## Requisitos del proyecto

### 1) App universal y adaptable
- **iPhone (compact):** navegación clásica con `UINavigationController` (push).
- **iPad (regular):** interfaz **Split View** con lista (columna izquierda) + detalle (columna derecha).
- Layouts adaptados usando `UISplitViewController` y controladores embebidos en `UINavigationController`.

### 2) Modelo de datos
Se incluye un modelo completo similar al ejemplo de `Pelicula`:
- `Receta`: id, título, resumen, tiempo, dificultad, etiquetas, ingredientes, pasos, favorito.
- `Ingrediente`: nombre, cantidad.
- `Paso`: título, detalle, minutos.
- `Dificultad`: enum con casos (p. ej. fácil/media/difícil).
- `ItemCompra`: item de lista de compra (con estado comprado).

### 3) Mínimo de 3 controladores de iOS avanzado (cumplido y ampliado)
Se han implementado (y se usan en la app):
- `UISplitViewController` (**RootSplitViewController**) → universal iPad/iPhone.
- `UITabBarController` (**DetalleRecetaTabBarController**) → detalle con pestañas.
- `UICollectionViewController` (**PasosCollectionViewController**) → pasos en formato tarjetas.
Además:
- `UITableViewController` para lista de recetas, ingredientes y lista de compra.
- `UISearchController` para búsqueda.

## Funcionalidades principales

### Recetas
- Listado de recetas con información básica (tiempo y dificultad).
- Selección de receta:
  - iPhone: push al detalle.
  - iPad: detalle en la columna derecha del split.

### Detalle de receta (Tab Bar)
- **Resumen**: título, tiempo/dificultad y descripción.
- **Ingredientes**: tabla de ingredientes.
- **Pasos**: colección (tarjetas) con títulos y descripción.

### Búsqueda y filtro
- **Búsqueda** por **título + etiquetas** con `UISearchController`.
- **Filtro por dificultad** mediante `UIActionSheet`.

## Mejoras realizadas (extra)

### 1) Favoritos con persistencia
- Marcar/quitar favorito con gesto swipe en la lista.
- Se muestran con **corazón**.
- Persistencia en `UserDefaults` guardando los **UUID** de recetas favoritas.
- IDs de recetas fijados (UUID estables) para mantener favoritos entre ejecuciones.

### 2) Lista de compra completa (persistente)
- Desde **Ingredientes**: swipe **“Añadir”** → se añade a la lista de compra.
- Pantalla **Compra** accesible desde el icono 🛒 en la lista principal.
- En Compra:
  - Marcar como comprado (tap → check).
  - Borrar item (swipe).
  - Vaciar lista (botón).
  - **Compartir** la lista (Share Sheet con `UIActivityViewController`).
- Persistencia en `UserDefaults` almacenando `[ItemCompra]` codificado en JSON (`Codable`).
- 
## Estructura del proyecto 📁 (orientativa)
- **Modelo/**
  - `Receta`, `Ingrediente`, `Paso`, `Dificultad`, `ItemCompra`
  - # Para persistencia de datos: Receta Favorita y Lista de la compra
  - `AlmacenRecetas` (seed + favoritos persistentes)
  - `AlmacenCompra` (lista compra persistente)
- **UI/**
  - `RootSplitViewController`
  - `ListaRecetasViewController`
  - `DetalleRecetaTabBarController`
  - `ResumenRecetaViewController`
  - `IngredientesViewController`
  - `PasosCollectionViewController`
  - `ListaCompraViewController`
  - `PlaceholderDetalleViewController`
  - 
## Pruebas realizadas 
-appiphone.mp4
-appipad.mp4

