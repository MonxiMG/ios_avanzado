import UIKit

final class PasosCollectionViewController: UICollectionViewController {

    private let receta: Receta

    init(receta: Receta) {
        self.receta = receta

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12

        super.init(collectionViewLayout: layout)
        title = "Pasos"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no soportado")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        receta.pasos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let paso = receta.pasos[indexPath.item]

        // contenido
        var content = UIListContentConfiguration.subtitleCell()
        content.text = "\(indexPath.item + 1). \(paso.titulo)"
        content.secondaryText = paso.detalle
        content.secondaryTextProperties.numberOfLines = 3
        cell.contentConfiguration = content

        // estilo
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 14
        cell.layer.masksToBounds = true

        return cell
    }
}

// tamaño de celdas (adaptable)
extension PasosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32 // márgenes 16+16
        return CGSize(width: width, height: 90)
    }
}

