import Foundation
import UIKit

extension UITextField {
    
    @IBInspectable
    open var localizedPlaceholder: String {
        get { return placeholder ?? "" }
        set {
            placeholder = newValue.localized
        }
    }
    
    @IBInspectable
    open var localizedText: String {
        get { return text ?? "" }
        set {
            text = newValue.localized
        }
    }
}

extension UITextView {
    
    @IBInspectable
    open var localizedText: String {
        get { return text ?? "" }
        set {
            text = newValue.localized
        }
    }
}

extension UIBarItem {
    
    @IBInspectable
    open var localizedTitle: String {
        get { return title ?? "" }
        set {
            title = newValue.localized
        }
    }
}

extension UILabel {
    
    @IBInspectable
    open var localizedText: String {
        get { return text ?? "" }
        set {
            text = newValue.localized
        }
    }
}

extension UINavigationItem {
    
    @IBInspectable
    open var localizedTitle: String {
        get { return title ?? "" }
        set {
            title = newValue.localized
        }
    }
}

extension UIButton {
    
    @IBInspectable
    open var localizedTitle: String {
        get { return title(for: UIControl.State()) ?? "" }
        set {
            setTitle(newValue.localized, for: UIControl.State())
        }
    }
}

extension UISearchBar {
    
    @IBInspectable
    open var localizedPrompt: String {
        get { return prompt ?? "" }
        set {
            prompt = newValue.localized
        }
    }
    
    @IBInspectable
    open var localizedPlaceholder: String {
        get { return placeholder ?? "" }
        set {
            placeholder = newValue.localized
        }
    }
}

extension UISegmentedControl {
    
    @IBInspectable
    open var localized: String {
        get { return titleForSegment(at: selectedSegmentIndex) ?? "" }
        set {
            for index in 0..<numberOfSegments {
                if let title = titleForSegment(at: index) {
                    setTitle(title.localized, forSegmentAt: index)
                }
            }
        }
    }
}
