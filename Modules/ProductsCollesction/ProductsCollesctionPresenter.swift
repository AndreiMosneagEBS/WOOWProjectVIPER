//
//  ProductsCollesctionPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 08/08/2022.
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
    var countProduct: Bool = false
    var page: Int = 1
    var isPageRefreshing:Bool = false
    var totalPages: Int = 0
    var cells: [ProductsCollesctionCellType] = []
    private var isDescSort: Bool = true {
        willSet {
            if newValue {
                
                products.sort(by: > )
            } else {
                products.sort(by: < )
            }
        }
    }
    
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
    
    private func generateCells() {
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
    
    func didTapMyCard() {
        self.router.showMyCard()
    }
    
    func didTapFavoriteButtonView() {
        let favorites = FavoriteManager.shared.getFavorites()
        self.router.didTapFavortesView(favorite: favorites)
    }
    
    func didTapFavorite(model: About) {
        FavoriteManager.shared.saveToFavorite(model: model)
        generateCells()
    }
    
    func didTapAddCart(model: About) {
        CartManager.shared.saveToCart(model: model)
        generateCells()
    }
    
    func didTapFilterButton() {
       isDescSort = !isDescSort
        cells.removeAll()
        generateCells()
    }
    
    func didTapCell(model: About) {
        self.router.didTapCell(model: model)
    }
    
    func didTapButtonProfile() {
        self.router.didTapButtonProfile()
    }
    
    func viewIsReady() {
        view.setupInitialState()
        self.baseVC.showHud()
        self.interactor.getProducts(pag: page)

    }
    
    func pagination() {
        if !isPageRefreshing {
            isPageRefreshing = true
            page += 1
            self.baseVC.showHud()
            self.interactor.getProducts(pag: page)
        }
    }
}

// MARK: - ProductsCollesctionInteractorOutput

extension ProductsCollesctionPresenter: ProductsCollesctionInteractorOutput {
    func didFetchProductsSuccess(products: ProductsResults, countProductPerPage: Bool) {
        baseVC.hideHud()
        self.countProduct = countProductPerPage
        self.totalPages = products.totalPages ?? 0
        
        if let products = products.results {
            self.products = products
        }
        
        if page == totalPages {
            self.isPageRefreshing = true
        } else {
            self.isPageRefreshing = false
        }
        generateCells()
    }
    
    func didFetchProductsError(error: Error) {
        baseVC.hideHud()
        print(error.localizedDescription)
    }
}

