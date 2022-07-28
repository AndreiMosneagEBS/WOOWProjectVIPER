import UIKit

extension UIColor {
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        let red = interval(0, r, 255)
        let green = interval(0, g, 255)
        let blue = interval(0, b, 255)
        let alpha = interval(0, a, 1)
        
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    public convenience init(hex: String, alpha: CGFloat = 1) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
    
    open func alpha(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
}

private func interval<T: Comparable>(_ minimum: T, _ num: T, _ maximum: T) -> T {
    return min(maximum, max(minimum, num))
}
