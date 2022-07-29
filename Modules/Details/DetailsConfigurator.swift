//
//  DetailsConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 29/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class DetailsModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: DetailsViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: DetailsViewController) {

        let router = DetailsRouter()
        router.viewController = viewController

        let presenter = DetailsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = DetailsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as DetailsModuleInput
    }
}
