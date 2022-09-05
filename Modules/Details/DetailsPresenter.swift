//
//  DetailsPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 29/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation
import SwiftUI

protocol DetailsModuleInput: AnyObject {
    func setup(productID: About)
}

final class DetailsPresenter {
    weak var view: DetailsViewInput!
	
    var interactor: DetailsInteractorInput!
    var router: DetailsRouterInput!
    
    private var productDetails: ProductDetails?
    private var productID: Int?
    private var model: About?
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
}

// MARK: - DetailsModuleInput

extension DetailsPresenter: DetailsModuleInput {
    func setup(productID: About) {
        self.productID = productID.id
        self.model = productID
    }
    

}

// MARK: - DetailsViewOutput

extension DetailsPresenter: DetailsViewOutput {
    func didTapAddToCard() {
        if let model = model{
            CartManager.shared.saveToCart(model: model)            
        }
    }
    
    func didTapOnImage(model: String?) {
        router.didTapImage(image: model)
    }
    
    
    func viewIsReady() {
        baseVC.showHud()
        view.setupInitialState()
        if let id = productID  {
            interactor.getProductDetails(id: id)
        }
    }
}


// MARK: - DetailsInteractorOutput

extension DetailsPresenter: DetailsInteractorOutput {
    func didFetchProductSuccess(product: ProductDetails) {
        baseVC.hideHud()
        self.productDetails = product
        self.view.setup(model: product)
        
    }
    
    func didFetchProductError(error: Error) {
        baseVC.hideHud()
        print(error.localizedDescription)
    }
    

}
