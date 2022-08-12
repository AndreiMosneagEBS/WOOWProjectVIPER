//
//  FavoritesConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class FavoritesModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: FavoritesViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: FavoritesViewController) {

        let router = FavoritesRouter()
        router.viewController = viewController

        let presenter = FavoritesPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = FavoritesInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as FavoritesModuleInput
    }
}
