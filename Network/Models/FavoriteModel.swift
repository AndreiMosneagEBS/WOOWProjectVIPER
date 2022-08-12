//
//  FavoriteModel.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 10.08.2022.
//

import Foundation
import RealmSwift

class FavoriteModel: Object {
    
    @Persisted(primaryKey: true)
    @objc dynamic var id: Int
    @Persisted var name: String = ""
    @Persisted var size: String = ""
    @Persisted var price: Int
    @Persisted var priceSale: Int
    @Persisted var image: String = ""
    
    convenience init(id: Int, name: String, size: String, price: Int, priceSale: Int, image: String) {
        self.init()
        self.id = id
        self.name = name
        self.size = size
        self.price = price
        self.priceSale = price
        self.image = image
    }

}
