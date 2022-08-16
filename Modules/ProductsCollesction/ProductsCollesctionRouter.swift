//
//  ProductsCollesctionRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 08/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProductsCollesctionRouterInput {
    func didTapCell(model: About)
    func didTapButtonProfile()
    func didTapFavortesView(favorite: [FavoriteModel])
    func showMyCard()

}

final class ProductsCollesctionRouter: ProductsCollesctionRouterInput {
    
    func didTapFavortesView(favorite: [FavoriteModel]) {
        let vc = FavoritesViewController.instantiate()
        vc.moduleInput.setup(model: favorite)
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
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
    
    func showMyCard() {
        let vc = BayViewController.instantiate()
        let cartModel: [CartModel] = CartManager.shared.getCarts()
        vc.moduleInput.setup(model: cartModel)
        viewController.navigationController?.pushViewController(vc, animated: true )
    }

    
    weak var viewController: ProductsCollesctionViewController!
}
