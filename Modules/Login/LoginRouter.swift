//
//  LoginRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol LoginRouterInput {
func didTapAccount()
func didTapLoginButton()
}

final class LoginRouter: LoginRouterInput {
    func didTapLoginButton() {
        let vc = ProductsViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
        
    }
    
    
    func didTapAccount() {
        let vc = CreateAcountViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
	weak var viewController: LoginViewController!
    
    
}
