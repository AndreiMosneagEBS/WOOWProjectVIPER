//
//  DetailsInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 29/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol DetailsInteractorInput {
    func getProductDetails(id: Int)
}

protocol DetailsInteractorOutput: AnyObject {
    func didFetchProductSuccess(product: ProductDetails)
    func didFetchProductError(error: Error)

}

final class DetailsInteractor: DetailsInteractorInput {
    weak var output: DetailsInteractorOutput!
    
    
    func getProductDetails(id: Int) {
        Request.shared.getDetails(id: id) { results in
            switch results {
            case .success(let product):
                print(product)
                self.output.didFetchProductSuccess(product: product)
            case .failure(let error):
                self.output.didFetchProductError(error: error)
            }
        }
    }
}



