//
//  ProfilePresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 03/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProfileModuleInput: AnyObject {

}

final class ProfilePresenter {
    weak var view: ProfileViewInput!
	
    var interactor: ProfileInteractorInput!
    var router: ProfileRouterInput!
	
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
}

// MARK: - ProfileModuleInput

extension ProfilePresenter: ProfileModuleInput {

}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
	func viewIsReady() {
		view.setupInitialState()
    }
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {

}
