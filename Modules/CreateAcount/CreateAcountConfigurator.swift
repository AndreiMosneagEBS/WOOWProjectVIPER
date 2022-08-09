//
//  CreateAcountConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class CreateAcountModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: CreateAcountViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: CreateAcountViewController) {

        let router = CreateAcountRouter()
        router.viewController = viewController

        let presenter = CreateAcountPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CreateAcountInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as CreateAcountModuleInput
    }
}
