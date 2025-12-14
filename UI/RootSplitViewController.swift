import UIKit

final class RootSplitViewController: UISplitViewController {

    private let listaVC = ListaRecetasViewController(style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredDisplayMode = .oneBesideSecondary
        preferredSplitBehavior = .tile

        // La lista irá en la columna principal dentro de un NavigationController
        let primaryNav = UINavigationController(rootViewController: listaVC)

        // Placeholder para iPad (antes de seleccionar una receta)
        let placeholder = PlaceholderDetalleViewController()
        let secondaryNav = UINavigationController(rootViewController: placeholder)

        setViewController(primaryNav, for: .primary)
        setViewController(secondaryNav, for: .secondary)

        // Conexión para que al seleccionar receta, actualicemos el detalle
        listaVC.delegate = self
    }
}

extension RootSplitViewController: ListaRecetasViewControllerDelegate {
    func listaRecetasViewController(_ vc: ListaRecetasViewController, didSelect receta: Receta) {
        let detalle = DetalleRecetaTabBarController(receta: receta)
        let secondaryNav = UINavigationController(rootViewController: detalle)
        showDetailViewController(secondaryNav, sender: self)
    }
}

