//
//  ProductsPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 28/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsModuleInput: AnyObject {

}

final class ProductsPresenter {
    weak var view: ProductsViewInput!
	
    var interactor: ProductsInteractorInput!
    var router: ProductsRouterInput!
    var products: [About] = []
    var page: Int?
    var countProduct: Bool?
    
	private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
    
    private func generateCells() {
        var cells: [ProductsCellType] = []
        products.forEach { product in
            cells.append(contentsOf: [
                .products(product: product)
            ])
        }
        
        view.didUpdateTableStructure(cells: cells, countOfProductsPerPage: countProduct!)
    }
    
    private func fetchProduct() {
        baseVC.showHud()
     
    }
}

// MARK: - ProductsModuleInput

extension ProductsPresenter: ProductsModuleInput {

}

// MARK: - ProductsViewOutput

extension ProductsPresenter: ProductsViewOutput {
    func didTapButtonProfile() {
        router.didTapButtonProfile()
    }
    
    func pagination(page: Int) {
        interactor.getProducts(pag: page)
        
    }
    
    func didTapOnCell(model: About) {
        router.didTapCell(model: model)
    }
    
    
	func viewIsReady() {
        view.setupInitialState()
        fetchProduct()
    }
}

// MARK: - ProductsInteractorOutput

extension ProductsPresenter: ProductsInteractorOutput {
    func didFetchProductsSuccess(products: ProductsResults, countProductPerPage: Bool) {
        baseVC.hideHud()
        self.countProduct = countProductPerPage
        if let products = products.results {
            self.products.append(contentsOf: products)
        }
        generateCells()
    }
    
    func didFetchProductsError(error: Error) {
        baseVC.hideHud()
        print(error.localizedDescription)
    }
}




