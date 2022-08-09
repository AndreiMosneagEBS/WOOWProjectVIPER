//
//  LoginConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class LoginModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: LoginViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: LoginViewController) {

        let router = LoginRouter()
        router.viewController = viewController

        let presenter = LoginPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = LoginInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as LoginModuleInput
    }
}
