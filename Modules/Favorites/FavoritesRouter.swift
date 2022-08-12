//
//  FavoritesRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol FavoritesRouterInput {
 func didSelectCell()
}

final class FavoritesRouter: FavoritesRouterInput {
    func didSelectCell() {
        let vc = ProductsCollesctionViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
	weak var viewController: FavoritesViewController!
}
