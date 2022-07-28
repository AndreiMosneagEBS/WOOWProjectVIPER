import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    public static var identifier: String {
        return String(describing: self)
    }
}
