//
//  CreateAcountRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol CreateAcountRouterInput {
    func didTapSignUp()
}

final class CreateAcountRouter: CreateAcountRouterInput {
    func didTapSignUp() {
        let vc = LoginViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
    weak var viewController: CreateAcountViewController!
    
    
}
