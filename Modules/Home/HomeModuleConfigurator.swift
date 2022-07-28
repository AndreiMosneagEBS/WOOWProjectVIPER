//
//  HomeConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 26/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class HomeModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: HomeViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: HomeViewController) {

        let router = HomeRouter()
        router.viewController = viewController

        let presenter = HomePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = HomeInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as HomeModuleInput
    }
}
