import UIKit

extension UITableView {
    open func register(_ cell: UITableViewCell.Type...) {
        cell.forEach {
            let nib = UINib(nibName: $0.identifier, bundle: nil)
            register(nib, forCellReuseIdentifier: $0.identifier)
        }
    }
    
    /// dequeue as subscript. Example: let cell = tableView[CellType.self, indexPath]
    open subscript<CellClass: UITableViewCell>(cellType: CellClass.Type, indexPath: IndexPath) -> CellClass {
        return dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as! CellClass
    }
    
    /// dequeue as subscript. Example: let cell = tableView[CellType.self]
    open subscript<CellClass: UITableViewCell>(cellType: CellClass.Type) -> CellClass {
        return dequeueReusableCell(withIdentifier: cellType.identifier) as! CellClass
    }
}

extension UICollectionView {
    open func register(_ cell: UICollectionViewCell.Type...) {
        cell.forEach {
            let nib = UINib(nibName: $0.identifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: $0.identifier)
        }
    }
    
    open func register(header: UICollectionReusableView.Type...) {
        header.forEach {
            let nib = UINib(nibName: $0.identifier, bundle: nil)
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: $0.identifier)
        }
    }
    
    open func register(footer: UICollectionReusableView.Type...) {
        footer.forEach {
            let nib = UINib(nibName: $0.identifier, bundle: nil)
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: $0.identifier)
        }
    }
    
    /// dequeue as subscript. Example: let cell = collectionView[CellType.self, indexPath]
    open subscript<CellClass: UICollectionViewCell>(cellType: CellClass.Type, indexPath: IndexPath) -> CellClass {
        return dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! CellClass
    }
    
    open func header<HeaderClass: UICollectionReusableView>(_ type: HeaderClass.Type, indexPath: IndexPath) -> HeaderClass {
        let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                      withReuseIdentifier: type.identifier,
                                                      for: indexPath) as! HeaderClass
        return header
    }
    
    open func footer<FooterClass: UICollectionReusableView>(_ type: FooterClass.Type, indexPath: IndexPath) -> FooterClass {
        let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                      withReuseIdentifier: type.identifier,
                                                      for: indexPath) as! FooterClass
        return header
    }
}
