import Foundation

public class SwiftUtils {
    private static var debugWindow = DebugWindow()
    
    static public var trackLocalizations = false
    
    static public func showDebugWindow() {
        debugWindow.show()
    }
    
    static public func hideDebugWindow() {
        debugWindow.hide()
    }
}
