//
//  ImagePresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 02/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ImageModuleInput: AnyObject {
    func setup(model: String?)
}

final class ImagePresenter {
    weak var view: ImageViewInput!
	
    var interactor: ImageInteractorInput!
    var router: ImageRouterInput!
    var image: String?
	
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
}

// MARK: - ImageModuleInput

extension ImagePresenter: ImageModuleInput {
    func setup(model: String?) {
        self.image = model
        if let model = model {
            self.view.setupImage(model: model)
        }
    }
    

}

// MARK: - ImageViewOutput

extension ImagePresenter: ImageViewOutput {
	func viewIsReady() {
		view.setupInitialState()
    }
}

// MARK: - ImageInteractorOutput

extension ImagePresenter: ImageInteractorOutput {

}
