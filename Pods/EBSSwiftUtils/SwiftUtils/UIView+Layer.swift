import Foundation
import UIKit

// MARK: - layer inspectable
extension UIView {
    
    @IBInspectable
    open var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    open var roundCornerRadius: Bool {
        get { return self.roundCornerRadius }
        set {
            if newValue {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    @IBInspectable
    open var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    open var borderColor: UIColor {
        get {
            guard let cgColor = layer.borderColor else {
                return .black
            }
            
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    open func setCornerRadius(_ radius: CGFloat, corners: UIRectCorner) {
        layer.masksToBounds = true
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

// MARK: - sketch shadow

extension UIView {
    open func applyShadow(cornerRadius: CGFloat = 0,
                          color: UIColor = .black,
                          shadowOpacity: Float = 0.5,
                          blur: CGFloat = 2,
                          size: CGSize=CGSize(width: 0, height: 1)
        ) {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowRadius = blur / 2
        layer.shadowColor = color.cgColor
        layer.shadowOffset = size
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    open func removeShadow() {
        layer.shadowPath = nil
    }
}
