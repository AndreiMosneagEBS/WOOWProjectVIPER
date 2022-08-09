//
//  ProfileRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 03/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProfileRouterInput {
func logout()
}

final class ProfileRouter: ProfileRouterInput {
    func logout() {
        let vc = HomeViewController.instantiate()
        viewController.navigationController?.pushViewController(vc, animated: true )
    }
    
	weak var viewController: ProfileViewController!
}
