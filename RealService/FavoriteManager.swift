//
//  FavoriteManager.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 10.08.2022.
//

import Foundation
import RealmSwift

struct FavoriteManager {
    static let shared = FavoriteManager()
    
   
    let realm = try! Realm()
    
    func saveToFavorite(model: About) {
        if checkFavorite(id: model.id ?? 0 ) {
            try? delete(id: model.id ?? 0)
        } else {
            try? add(model: model)
        }
    }
    
    func checkFavorite(id: Int) -> Bool {
        let object = getFavorite(id: id )
        return object != nil
        
    }
    
    func getFavorite(id: Int) -> FavoriteModel? {
        return realm.objects(FavoriteModel.self).filter("id == %@", id).first
    }
    
    func delete(id: Int) throws {
        try realm.write{
            if let object = getFavorite(id: id) {
                realm.delete(object)
            }
        }
    }
    
    func add(model: About) throws {
        try realm.write({
            let favorite: FavoriteModel = FavoriteModel(id: model.id ?? 0,
                                                        name: model.name ?? "",
                                                        size: model.size ?? "",
                                                        price: model.price ?? 0,
                                                        priceSale: model.price ?? 0,
                                                        image: model.mainImage ?? "")
            realm.add(favorite)
        })
    }
    
    func getFavorites() -> [FavoriteModel] {
        let result = realm.objects(FavoriteModel.self)
        return Array(result)
    }
    

}
