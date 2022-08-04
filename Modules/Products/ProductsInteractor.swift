//
//  ProductsInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 28/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsInteractorInput {
    func getProducts(pag: Int)
}

protocol ProductsInteractorOutput: AnyObject {
    func didFetchProductsSuccess(products: [About], countProductPerPage: Bool)
    func didFetchProductsError(error: Error)
}

final class ProductsInteractor: ProductsInteractorInput {
    weak var output: ProductsInteractorOutput!
    
    var countProductPerPage: Bool = true

    func getProducts(pag: Int) {
        Request.shared.fetchProducts(page: pag) { results in
            switch results {
            case .success(let products):
                if products.count != 10 {
                    self.countProductPerPage = false
                }
                self.output.didFetchProductsSuccess(products: products, countProductPerPage: self.countProductPerPage )
            case .failure(let error):
                self.output.didFetchProductsError(error: error)
            }
        }
    }
}
