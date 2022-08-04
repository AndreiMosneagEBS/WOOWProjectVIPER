//
//  DetailsRouter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 29/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol DetailsRouterInput {
    func didTapImage(image:String?)
}

final class DetailsRouter: DetailsRouterInput {
    func didTapImage(image: String?) {
        let vcImage = ImageViewController.instantiate()
        vcImage.moduleInput.setup(model:image)
        viewController.navigationController?.pushViewController(vcImage, animated: true )

    }
    
	weak var viewController: DetailsViewController!
}
