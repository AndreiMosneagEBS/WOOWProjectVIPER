//
//  ProductsCollesctionRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 08/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsCollesctionRouterInput {
    func didTapCell(model: About)
    func didTapButtonProfile()

}

final class ProductsCollesctionRouter: ProductsCollesctionRouterInput {
    func didTapCell(model: About) {
        let vc = DetailsViewController.instantiate()
        if let id = model.id {
            vc.moduleInput.setup(productID: id)
        }
        viewController.navigationController?.pushViewController(vc, animated: true )

    }
    
    func didTapButtonProfile() {
        let vc = ProfileViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
	weak var viewController: ProductsCollesctionViewController!
}
