//
//  ProductsInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 28/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsInteractorInput {
    func getProducts()
}

protocol ProductsInteractorOutput: AnyObject {
    func didFetchProductsSuccess(products: [About])
    func didFetchProductsError(error: Error)
}

final class ProductsInteractor: ProductsInteractorInput {
    weak var output: ProductsInteractorOutput!

    func getProducts() {
        Request.shared.fetchProducts(page: 1) { results in
            switch results {
            case .success(let products):
                self.output.didFetchProductsSuccess(products: products)
            case .failure(let error):
                self.output.didFetchProductsError(error: error)
            }
        }
    }
}
