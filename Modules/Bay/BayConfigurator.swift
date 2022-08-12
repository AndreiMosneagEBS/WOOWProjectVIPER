//
//  BayConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class BayModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: BayViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: BayViewController) {

        let router = BayRouter()
        router.viewController = viewController

        let presenter = BayPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = BayInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as BayModuleInput
    }
}
