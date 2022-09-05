//
//  CartManager.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 12.08.2022.
//

import Foundation
import RealmSwift

struct CartManager {
    static let shared = CartManager()
    
    
    let realm = try! Realm()
    
    
    
    func observerChange() {
        
    }
    
    func saveToCart(model: About) {
        if checkCart(id: model.id ?? 0 ) {
            try? delete(id: model.id ?? 0)
        } else {
            try? add(model: model)
        }
        
    }
    
    func checkCart(id: Int) -> Bool {
        let object = getCart(id: id )
        return object != nil
        
    }
    
    func getCart(id: Int) -> CartModel? {
        return realm.objects(CartModel.self).filter("id == %@", id).first
    }
    
    func delete(id: Int) throws {
        try realm.write{
            if let object = getCart(id: id) {
                realm.delete(object)
            }
        }
    }
    
    func add(model: About) throws {
        try realm.write({
            let favorite: CartModel = CartModel(id: model.id ?? 0,
                                                name: model.name ?? "",
                                                size: model.size ?? "",
                                                price: model.price ?? 0,
                                                priceSale: model.price ?? 0,
                                                image: model.mainImage ?? "",
                                                count: 1,
                                                totalPrice: model.price ?? 0
            )
            realm.add(favorite)
        })
    }
    
    func getCarts() -> [CartModel] {
        let result = realm.objects(CartModel.self)
        return Array(result)
    }
    
    func countCart() -> Int {
        let count = realm.objects(CartModel.self).count
        return count
    }
}
