//
//  CartModel.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 15.08.2022.
//

import Foundation
import RealmSwift

class CartModel: Object {
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted var name: String = ""
    @Persisted var size: String = ""
    @Persisted var price: Int
    @Persisted var priceSale: Int
    @Persisted var image: String = ""
    @Persisted var count: Int = 1

    
    convenience init(id: Int, name: String, size: String, price: Int, priceSale: Int, image: String, count: Int) {
        self.init()
        self.id = id
        self.name = name
        self.size = size
        self.price = price
        self.priceSale = price
        self.image = image
        
        if count > 1 {
            self.count = count
        }
    }

}
