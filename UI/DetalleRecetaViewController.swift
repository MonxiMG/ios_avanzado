import UIKit

final class DetalleRecetaViewController: UIViewController {

    private let receta: Receta

    init(receta: Receta) {
        self.receta = receta
        super.init(nibName: nil, bundle: nil)
        title = receta.titulo
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no soportado")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let titulo = UILabel()
        titulo.font = .preferredFont(forTextStyle: .title2)
        titulo.numberOfLines = 0
        titulo.text = receta.titulo

        let info = UILabel()
        info.font = .preferredFont(forTextStyle: .subheadline)
        info.textColor = .secondaryLabel
        info.numberOfLines = 0
        info.text = "\(receta.textoTiempo) · \(receta.dificultad.titulo)"

        let resumen = UILabel()
        resumen.font = .preferredFont(forTextStyle: .body)
        resumen.numberOfLines = 0
        resumen.text = receta.resumen

        let stack = UIStackView(arrangedSubviews: [titulo, info, resumen])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
}

