import UIKit

open class InsetsLabel: UILabel {
    private var labelInsets = UIEdgeInsets.zero
    
    @IBInspectable public var topInset: CGFloat {
        get { return labelInsets.top }
        set {
            labelInsets.top = newValue
        }
    }
    
    @IBInspectable public var leftInset: CGFloat {
        get { return labelInsets.left }
        set {
            labelInsets.left = newValue
        }
    }
    
    @IBInspectable public var bottomInset: CGFloat {
        get { return labelInsets.bottom }
        set {
            labelInsets.bottom = newValue
        }
    }
    
    @IBInspectable public var rightInset: CGFloat {
        get { return labelInsets.right }
        set {
            labelInsets.right = newValue
        }
    }
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: labelInsets))
    }
    
    override open var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += labelInsets.top + labelInsets.bottom
        contentSize.width += labelInsets.left + labelInsets.right
        
        return contentSize
    }
}
