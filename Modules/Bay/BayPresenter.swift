//
//  BayPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol BayModuleInput: AnyObject {
    func setup(model: [CartModel])
}

final class BayPresenter {
    weak var view: BayViewInput!
    
    var interactor: BayInteractorInput!
    var router: BayRouterInput!
    
    private var cartProducts: [CartModel] = []
    
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
    
    private func generateCells() {
        var cells: [BayCellType] = []
        cartProducts.forEach { product in
            cells.append(contentsOf: [
                .poductBay(model: product)
            ])
        }
        view.didUpdateCollectionStructure(cells: cells)
    }
    
}

// MARK: - BayModuleInput

extension BayPresenter: BayModuleInput {
    func setup(model: [CartModel]) {
        self.cartProducts = model
    }
}

// MARK: - BayViewOutput

extension BayPresenter: BayViewOutput {
    func didTapPlus(productId: Int) {
        guard let index = cartProducts.firstIndex(where: { $0.id == productId }) else {
            return
        }
        
        let oldCount = cartProducts[index].count
        cartProducts[index].count = oldCount + 1
        
        generateCells()
    }
    
    func didTapMinus(productId: Int) {
        guard let index = cartProducts.firstIndex(where: { $0.id == productId }) else {
            return
        }
        
        let oldCount = cartProducts[index].count
        
        if oldCount == 0 {
            return
        }
        
        cartProducts[index].count = oldCount - 1
        
        generateCells()
    }
    
    func didTapDeleteProduct(id: Int) {
        try? CartManager.shared.delete(id: id)
        self.cartProducts = CartManager.shared.getCarts()
        generateCells()
    }
    
    func viewIsReady() {
        view.setupInitialState()
        generateCells()
    }
}

// MARK: - BayInteractorOutput

extension BayPresenter: BayInteractorOutput {

}
