//
//  ProfileConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 03/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class ProfileModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: ProfileViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: ProfileViewController) {

        let router = ProfileRouter()
        router.viewController = viewController

        let presenter = ProfilePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ProfileInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as ProfileModuleInput
    }
}
