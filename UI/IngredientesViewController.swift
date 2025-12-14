import UIKit

final class IngredientesViewController: UITableViewController {
    
    private let receta: Receta
    
    init(receta: Receta) {
        self.receta = receta
        super.init(style: .insetGrouped)
        title = "Ingredientes"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no soportado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receta.ingredientes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let ing = receta.ingredientes[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = ing.nombre
        content.secondaryText = ing.cantidad
        cell.contentConfiguration = content
        return cell
    }
    
//COMPRA
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let ing = receta.ingredientes[indexPath.row]

        let añadir = UIContextualAction(style: .normal, title: "Añadir") { _, _, done in
            AlmacenCompra.shared.añadir(
                nombre: ing.nombre,
                cantidad: ing.cantidad,
                recetaTitulo: self.receta.titulo
            )
            done(true)
        }

        añadir.backgroundColor = .systemGreen
        añadir.image = UIImage(systemName: "cart.badge.plus")

        return UISwipeActionsConfiguration(actions: [añadir])
    }

}

