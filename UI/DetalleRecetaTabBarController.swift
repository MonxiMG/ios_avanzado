import UIKit

final class DetalleRecetaTabBarController: UITabBarController {

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

        let resumenVC = ResumenRecetaViewController(receta: receta)
        resumenVC.tabBarItem = UITabBarItem(title: "Resumen", image: UIImage(systemName: "doc.text"), tag: 0)

        let ingredientesVC = IngredientesViewController(receta: receta)
        ingredientesVC.tabBarItem = UITabBarItem(title: "Ingredientes", image: UIImage(systemName: "list.bullet"), tag: 1)

        let pasosVC = PasosCollectionViewController(receta: receta)
        pasosVC.tabBarItem = UITabBarItem(title: "Pasos", image: UIImage(systemName: "square.grid.2x2"), tag: 2)

        viewControllers = [
            UINavigationController(rootViewController: resumenVC),
            UINavigationController(rootViewController: ingredientesVC),
            UINavigationController(rootViewController: pasosVC)
        ]
    }
}

