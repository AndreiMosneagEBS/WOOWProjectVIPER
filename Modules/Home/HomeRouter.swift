//
//  HomeRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 26/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol HomeRouterInput {
    func showProfileView()
}

final class HomeRouter: HomeRouterInput {
	weak var viewController: HomeViewController!
    
    func showProfileView() {
    
    }
}
