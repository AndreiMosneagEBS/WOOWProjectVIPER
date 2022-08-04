//
//  ImageConfigurator.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 02/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit

final class ImageModuleConfigurator: NSObject {

    @objc func configureModule(for viewController: ImageViewController) {
        configure(viewController: viewController)
    }

    private func configure(viewController: ImageViewController) {

        let router = ImageRouter()
        router.viewController = viewController

        let presenter = ImagePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ImageInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
        viewController.moduleInput = presenter as ImageModuleInput
    }
}
