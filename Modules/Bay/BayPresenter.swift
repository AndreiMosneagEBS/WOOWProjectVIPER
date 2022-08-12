//
//  BayPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol BayModuleInput: AnyObject {

}

final class BayPresenter {
    weak var view: BayViewInput!
	
    var interactor: BayInteractorInput!
    var router: BayRouterInput!
    
	private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
}

// MARK: - BayModuleInput

extension BayPresenter: BayModuleInput {

}

// MARK: - BayViewOutput

extension BayPresenter: BayViewOutput {
	func viewIsReady() {
		view.setupInitialState()
    }
}

// MARK: - BayInteractorOutput

extension BayPresenter: BayInteractorOutput {

}
