//
//  BayInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol BayInteractorInput {

}

protocol BayInteractorOutput: AnyObject {

}

final class BayInteractor: BayInteractorInput {
    weak var output: BayInteractorOutput!

}
