//
//  HomeRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 26/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterInput {
    func showProfileView()
    func didTapLogIn()
    func didTapGuest()
    
}

final class HomeRouter: HomeRouterInput {
    
    func didTapGuest() {
        let vc = LoginViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
    
   
    func didTapLogIn() {
        
        let vc = ProductsCollesctionViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
	weak var viewController: HomeViewController!
    
    func showProfileView() {
    
    }
}
