//
//  ProductsConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 28/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class ProductsModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: ProductsViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: ProductsViewController) {

        let router = ProductsRouter()
        router.viewController = viewController

        let presenter = ProductsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ProductsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as ProductsModuleInput
    }
}
