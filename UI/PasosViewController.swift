import UIKit

final class PasosViewController: UITableViewController {

    private let receta: Receta

    init(receta: Receta) {
        self.receta = receta
        super.init(style: .insetGrouped)
        title = "Pasos"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no soportado")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receta.pasos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let paso = receta.pasos[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = paso.titulo
        content.secondaryText = paso.detalle
        content.secondaryTextProperties.numberOfLines = 2
        cell.contentConfiguration = content

        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

