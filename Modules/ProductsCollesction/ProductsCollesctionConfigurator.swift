//
//  ProductsCollesctionConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 08/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class ProductsCollesctionModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: ProductsCollesctionViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: ProductsCollesctionViewController) {

        let router = ProductsCollesctionRouter()
        router.viewController = viewController

        let presenter = ProductsCollesctionPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ProductsCollesctionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as ProductsCollesctionModuleInput
    }
}
