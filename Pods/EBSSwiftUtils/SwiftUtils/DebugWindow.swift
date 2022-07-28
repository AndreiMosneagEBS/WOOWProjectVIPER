import UIKit

final class DebugWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    convenience init() {
        let width: CGFloat = 40
        var frame = UIScreen.main.bounds
        frame.origin.x = frame.width - width - 10
        frame.origin.y = frame.height - width - 10
        frame.size.width = width
        frame.size.height = width
        self.init(frame: frame)
        
        backgroundColor = UIColor.lightGray.alpha(0.6)
        rootViewController = UIViewController()
        clipsToBounds = true
        layer.cornerRadius = width / 2
        borderColor = .black
        borderWidth = 1
        addSubview(infoLabel)
        isUserInteractionEnabled = true
        addPanGestureRecognizer()
    }
    
    func show() {
        DispatchQueue.main.async { [weak self] in
            self?.makeKeyAndVisible()
        }
    }
    
    func hide() {
        isHidden = true
    }
    
    private var infoLabel: InsetsLabel {
        let label = InsetsLabel(frame: bounds)
        label.clipsToBounds = true
        label.topInset = 8
        label.bottomInset = 8
        label.leftInset = 8
        label.rightInset = 8
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.text = version
        label.numberOfLines = 0
        label.textAlignment = .center
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }
    
    private var version: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String else {
                return "???"
        }
        
        return "v\(version)\nb\(build)"
    }
    
    private func addPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        if shouldStop { return }
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        let translation = sender.translation(in: keyWindow)
        center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
        sender.setTranslation(.zero, in: keyWindow)
        adjustFrame()
    }
    
    private var shouldStop: Bool {
        let leftBounds = frame.origin.x < 0
        let rightBounds = (frame.origin.x + frame.width) > UIScreen.main.bounds.width
        let topBounds = frame.origin.y < 0
        let bottomBounds = (frame.origin.y + frame.height) > UIScreen.main.bounds.height
        return leftBounds || rightBounds || topBounds || bottomBounds
    }
    
    private func adjustFrame() {
        var frame = self.frame
        let leftBounds = frame.origin.x < 0
        if leftBounds {
            frame.origin.x = 0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.frame = frame
            }
        }
        
        let rightBounds = (frame.origin.x + frame.width) > UIScreen.main.bounds.width
        if rightBounds {
            frame.origin.x = UIScreen.main.bounds.width - frame.width
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.frame = frame
            }
        }
        
        let topBounds = frame.origin.y < 0
        if topBounds {
            frame.origin.y = 0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.frame = frame
            }
        }
        
        let bottomBounds = (frame.origin.y + frame.height) > UIScreen.main.bounds.height
        if bottomBounds {
            frame.origin.y = UIScreen.main.bounds.height - frame.height
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.frame = frame
            }
        }
    }
}
