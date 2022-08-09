//
//  Extension.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 29.07.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String, displayPlaceholder: Bool = false) {
        let placeholderImage = UIImage(systemName: "nosign")?.withTintColor(.darkGray)
        if displayPlaceholder {
            self.image = placeholderImage
        }
        guard let url = URL.init(string: urlString) else {
            return
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholderImage)
    }
}

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}

extension String {
     func savaDataBasekey()-> String {
         return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    }

}
