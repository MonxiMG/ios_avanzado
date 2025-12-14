import UIKit


protocol ListaRecetasViewControllerDelegate: AnyObject {
    func listaRecetasViewController(_ vc: ListaRecetasViewController, didSelect receta: Receta)
}

final class ListaRecetasViewController: UITableViewController {
    
    private var recetas: [Receta] = AlmacenRecetas.shared.recetas
    
    weak var delegate: ListaRecetasViewControllerDelegate?
    private var todas: [Receta] = AlmacenRecetas.shared.recetas
    private var filtradas: [Receta] = []
    private var dificultadSeleccionada: Dificultad? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recetas"
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Buscar receta..."
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        let btnFiltrar = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(tocarFiltrar))
        let btnCompra = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(abrirCompra))
        navigationItem.rightBarButtonItems = [btnFiltrar, btnCompra]

        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //recetas.count
        return listaActual().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let r = listaActual()[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = r.titulo
        content.secondaryText = "\(r.textoTiempo) · \(r.dificultad.titulo)"
        cell.contentConfiguration = content
        
        cell.imageView?.image = r.esFavorita ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.imageView?.tintColor = .systemYellow
        
        
        cell.accessoryType = .disclosureIndicator
        
        //Corazón de favorito
        if r.esFavorita {
            cell.accessoryView = UIImageView(image: UIImage(systemName: "heart.fill"))
            (cell.accessoryView as? UIImageView)?.tintColor = .systemRed
        } else {
            cell.accessoryView = nil
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let r = listaActual()[indexPath.row]
        
        // Pata IPad
        if let delegate {
            delegate.listaRecetasViewController(self, didSelect: r)
            return
        }
        
        // Para iPhone
        let vc = DetalleRecetaTabBarController(receta: r)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func listaActual() -> [Receta] {
        let texto = navigationItem.searchController?.searchBar.text ?? ""
        if texto.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return todas
        } else {
            return filtradas
        }
    }
    
    private func aplicarFiltro(_ texto: String) {
        let q = texto.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else {
            filtradas = []
            tableView.reloadData()
            return
        }
        
        filtradas = todas.filter { r in
            
            if let d = dificultadSeleccionada, r.dificultad != d { return false }
            let enTitulo = r.titulo.lowercased().contains(q)
            let enEtiquetas = r.etiquetas.contains { $0.lowercased().contains(q) }
            return enTitulo || enEtiquetas
        }
        tableView.reloadData()
    }
    
    @objc private func tocarFiltrar() {
        let alert = UIAlertController(title: "Dificultad", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Todas", style: .default, handler: { _ in
            self.dificultadSeleccionada = nil
            self.aplicarFiltro(self.navigationItem.searchController?.searchBar.text ?? "")
        }))
        
        for d in Dificultad.allCases {
            alert.addAction(UIAlertAction(title: d.titulo, style: .default, handler: { _ in
                self.dificultadSeleccionada = d
                self.aplicarFiltro(self.navigationItem.searchController?.searchBar.text ?? "")
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        // iPad: acciónSheet necesita anchor
        if let pop = alert.popoverPresentationController {
            pop.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let r = listaActual()[indexPath.row]

        let action = UIContextualAction(style: .normal, title: r.esFavorita ? "Quitar" : "Favorito") { _, _, done in

            

                AlmacenRecetas.shared.toggleFavorito(id: r.id)

                // refrescar datos desde el almacén (ya vienen con esFavorita actualizado)
                self.todas = AlmacenRecetas.shared.recetas

                // reaplicar búsqueda/filtro
                self.aplicarFiltro(self.navigationItem.searchController?.searchBar.text ?? "")

                done(true)
            }


        action.backgroundColor = .systemOrange
        action.image = UIImage(systemName: r.esFavorita ? "heart.slash" : "heart")

        return UISwipeActionsConfiguration(actions: [action])
    }

}
extension ListaRecetasViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        aplicarFiltro(searchController.searchBar.text ?? "")
    }
    
    @objc private func abrirCompra() {
        let vc = ListaCompraViewController(style: .insetGrouped)
        navigationController?.pushViewController(vc, animated: true)
    }

}



