//
//  ProductsCollesctionInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 08/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsCollesctionInteractorInput {
    func getProducts(pag: Int)
}

protocol ProductsCollesctionInteractorOutput: AnyObject {
    func didFetchProductsSuccess(products: ProductsResults, countProductPerPage: Bool)
    func didFetchProductsError(error: Error)
}

final class ProductsCollesctionInteractor: ProductsCollesctionInteractorInput {
    weak var output: ProductsCollesctionInteractorOutput!
    
    var countProductPerPage: Bool = true

    func getProducts(pag: Int) {
        Request.shared.fetchProducts(page: pag) { results in
            switch results {
            case .success(let products):
//                if products.count != 10 {
//                    self.countProductPerPage = false
//                }
                self.output.didFetchProductsSuccess(products: products, countProductPerPage: self.countProductPerPage )
            case .failure(let error):
                self.output.didFetchProductsError(error: error)
            }
        }
    }
}
