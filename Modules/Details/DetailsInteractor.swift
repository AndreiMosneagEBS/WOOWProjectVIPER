//
//  DetailsInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 29/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol DetailsInteractorInput {

}

protocol DetailsInteractorOutput: AnyObject {

}

final class DetailsInteractor: DetailsInteractorInput {
    weak var output: DetailsInteractorOutput!

}
