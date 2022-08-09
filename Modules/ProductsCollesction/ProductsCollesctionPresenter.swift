//
//  ProductsCollesctionPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 08/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsCollesctionModuleInput: AnyObject {

}

final class ProductsCollesctionPresenter {
    weak var view: ProductsCollesctionViewInput!
	
    var interactor: ProductsCollesctionInteractorInput!
    var router: ProductsCollesctionRouterInput!
    var products: [About] = []
    var countProduct: Bool?
    var page: Int = 0
    var isPageRefreshing:Bool = false
    
	private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
    
    private func generateCells() {
        var cells: [ProductsCollesctionCellType] = []
        products.forEach { product in
            cells.append(contentsOf: [
                .product(product: product)
            ])
        }
        view.didUpdateCollectionStructure(cells: cells)
    }
    
    
    
}

// MARK: - ProductsCollesctionModuleInput

extension ProductsCollesctionPresenter: ProductsCollesctionModuleInput {

}

// MARK: - ProductsCollesctionViewOutput

extension ProductsCollesctionPresenter: ProductsCollesctionViewOutput {
	func viewIsReady() {
		view.setupInitialState()
        self.interactor.getProducts(pag: 1)

    }
    func pagination(pag: Int ) {
        
        if !isPageRefreshing {
                   isPageRefreshing = true
                   print(page)
                   page = page + 1
            self.interactor.getProducts(pag: page)
               }
    }
    
}

// MARK: - ProductsCollesctionInteractorOutput

extension ProductsCollesctionPresenter: ProductsCollesctionInteractorOutput {
    func didFetchProductsSuccess(products: [About], countProductPerPage: Bool) {
        baseVC.hideHud()
        self.countProduct = countProductPerPage
        self.products.append(contentsOf: products)
        generateCells()
    }
    
    func didFetchProductsError(error: Error) {
        baseVC.hideHud()
        print(error.localizedDescription)
    }

}
