import Foundation

extension String {
    public var localized: String {
        let table = "Localizable"
        let localizationTracker = LocalizationTracker()
        localizationTracker.handleLocalizations(table: table, key: self)
        let localized = NSLocalizedString(self, comment: "")
        
        return localized.isEmpty ? self : localized
    }
    
    public func localized(table: String) -> String {
        let localizationTracker = LocalizationTracker()
        localizationTracker.handleLocalizations(table: table, key: self)
        let localized = NSLocalizedString(self, tableName: table, comment: "")
        
        return localized.isEmpty ? self : localized
    }
    
    public func localized(arguments: CVarArg...) -> String {
        let table = "Localizable"
        let localizationTracker = LocalizationTracker()
        localizationTracker.handleLocalizations(table: table, key: self)
        let localized = String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
        
        return localized.isEmpty ? self : localized
    }
    
    public func localized(table: String, arguments: CVarArg...) -> String {
        let localizationTracker = LocalizationTracker()
        localizationTracker.handleLocalizations(table: table, key: self)
        let localized = String(format: NSLocalizedString(self, tableName: table, comment: ""), arguments: arguments)
        
        return localized.isEmpty ? self : localized
    }
}

open class LocalizationTracker {
    
    private func isSimulator(completion: (() -> Void)?) {
        #if targetEnvironment(simulator)
        completion?()
        #endif
    }
    
    func handleLocalizations(table: String, key: String) {
        if !SwiftUtils.trackLocalizations { return }
        isSimulator {
            LocalizationHandler.shared.currentTable = table
            LocalizationHandler.shared.initLocalizationsUtils()
            
            let tableDict = LocalizationHandler.shared.dictWithLanguages[table]
            LocalizationHandler.shared.checkIfKeyExist(in: tableDict, key: key)
        }
    }
}
