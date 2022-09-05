//
//  ProductsRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 28/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsRouterInput {
    func didTapCell(model: About)
    func didTapButtonProfile()
}

final class ProductsRouter: ProductsRouterInput {
    
    
    
    func didTapButtonProfile() {
        let vc = ProfileViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
    func didTapCell(model: About) {
        let vc = DetailsViewController.instantiate()
        vc.moduleInput.setup(productID: model)
//        if let id =  model.id {
//            vc.moduleInput.setup(productID: id)
//        }
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
	weak var viewController: ProductsViewController!
}
