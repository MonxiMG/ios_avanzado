import UIKit

final class ListaCompraViewController: UITableViewController {

    private var items: [ItemCompra] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Compra"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let btnVaciar = UIBarButtonItem(title: "Vaciar", style: .plain, target: self, action: #selector(vaciar))
        let btnCompartir = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(compartir))
        navigationItem.rightBarButtonItems = [btnVaciar, btnCompartir]


        recargar()
    }
    @objc private func compartir() {
        let items = AlmacenCompra.shared.items

        if items.isEmpty {
            let alert = UIAlertController(title: "Lista vacía", message: "No hay items para compartir.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let lineas = items.map { item in
            let estado = item.comprado ? "✅" : "⬜️"
            return "\(estado) \(item.nombre) — \(item.cantidad)  (\(item.recetaTitulo))"
        }

        let texto = "🛒 Lista de compra\n\n" + lineas.joined(separator: "\n")

        let vc = UIActivityViewController(activityItems: [texto], applicationActivities: nil)

        if let pop = vc.popoverPresentationController {
            pop.barButtonItem = navigationItem.rightBarButtonItems?.last
        }

        present(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recargar()
    }

    private func recargar() {
        items = AlmacenCompra.shared.items
        tableView.reloadData()
    }

    @objc private func vaciar() {
        AlmacenCompra.shared.vaciar()
        recargar()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = "\(item.nombre) — \(item.cantidad)"
        content.secondaryText = item.recetaTitulo
        cell.contentConfiguration = content

        cell.accessoryType = item.comprado ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        AlmacenCompra.shared.toggleComprado(id: item.id)
        recargar()
    }

    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = items[indexPath.row]

        let borrar = UIContextualAction(style: .destructive, title: "Borrar") { _, _, done in
            AlmacenCompra.shared.eliminar(id: item.id)
            self.recargar()
            done(true)
        }

        return UISwipeActionsConfiguration(actions: [borrar])
    }
}

