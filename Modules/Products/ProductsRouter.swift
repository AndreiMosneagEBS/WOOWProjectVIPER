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
}

final class ProductsRouter: ProductsRouterInput {
    func didTapCell(model: About) {
        let vc = DetailsViewController.instantiate()
        vc.moduleInput.setup(model: model)
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
	weak var viewController: ProductsViewController!
}
