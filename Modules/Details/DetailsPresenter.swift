//
//  DetailsPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 29/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol DetailsModuleInput: AnyObject {
    func setup(model: About)
}

final class DetailsPresenter {
    weak var view: DetailsViewInput!
	
    var interactor: DetailsInteractorInput!
    var router: DetailsRouterInput!
    
    private var model: About?
	
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
}

// MARK: - DetailsModuleInput

extension DetailsPresenter: DetailsModuleInput {
    func setup(model: About) {
        self.model = model
    }
    

}

// MARK: - DetailsViewOutput

extension DetailsPresenter: DetailsViewOutput {
	func viewIsReady() {
		view.setupInitialState()
        if let model = model {
            view.setup(model: model)
        }
    }
}

// MARK: - DetailsInteractorOutput

extension DetailsPresenter: DetailsInteractorOutput {

}
