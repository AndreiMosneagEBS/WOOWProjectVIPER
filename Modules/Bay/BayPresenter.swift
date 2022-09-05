//
//  BayPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation
import RealmSwift

protocol BayModuleInput: AnyObject {
    func setup(model: [CartModel])
}

final class BayPresenter {
    weak var view: BayViewInput!
    
    
    var interactor: BayInteractorInput!
    var router: BayRouterInput!
    var countProduct = 1
    var priceProd = 0
    var tPrice: [Int : Int] = [:]
    private var cartProducts: [CartModel] = []
    private var totalCountProd = 0
    private var productNotoficationToken: NotificationToken?
    private var realm: Realm {
        try! Realm()
    }
    
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
    
    func generateFinalPrice()-> Int {
        var totalPrice: Int = 0
        cartProducts.forEach({totalPrice += $0.totalPrice})
        return totalPrice
        
    }
    
    private func notificationChange() {
        let productCart = realm.objects(CartModel.self)
        productNotoficationToken = productCart.observe{ [self] change in
            switch change {
            case .initial(_):
                self.view.updateCardOfCount(count: CartManager.shared.countCart())
            case .update:
                print(CartManager.shared.countCart())
//                self.view.updateCardOfCount(count: CartManager.shared.countCart())
            case .error(let error):
                print(error)
            }
        }
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
    
    
    func totalPriceCout(price: Int) {
        priceProd =  price
        
    }
    
    func didTapPlus(productId: Int) {
        guard let index = cartProducts.firstIndex(where: { $0.id == productId }) else {
            return
        }
        let oldCount = cartProducts[index].count
        
        try? CartManager.shared.realm.write({
            cartProducts[index].count = oldCount + 1
            cartProducts[index].totalPrice = cartProducts[index].price * cartProducts[index].count
        })
        countProduct = oldCount
        tPrice[cartProducts[index].price] = oldCount
        view.setTotalPrice(price: generateFinalPrice())
        generateCells()
        
    }
    
    func didTapMinus(productId: Int) {
        guard let index = cartProducts.firstIndex(where: { $0.id == productId }) else {
            return
        }
        
        let oldCount = cartProducts[index].count
        if oldCount == 1 {
            return
        }
        
        try? CartManager.shared.realm.write({
            cartProducts[index].count = oldCount - 1
            cartProducts[index].totalPrice = cartProducts[index].price * cartProducts[index].count
        })
        
        countProduct = oldCount
        tPrice[cartProducts[index].price] = oldCount
        view.setTotalPrice(price: generateFinalPrice())
        generateCells()
        
    }
    
    func didTapDeleteProduct(id: Int) {
        try? CartManager.shared.delete(id: id)
        self.cartProducts = CartManager.shared.getCarts()
        view.setTotalPrice(price: generateFinalPrice())
        generateCells()
    }
    
    func viewIsReady() {
        view.setupInitialState()
        generateCells()
        view.setTotalPrice(price: generateFinalPrice())
        self.notificationChange()
    }
    
    
    
    
}

// MARK: - BayInteractorOutput

extension BayPresenter: BayInteractorOutput {
    
}
