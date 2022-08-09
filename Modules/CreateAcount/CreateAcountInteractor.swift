//
//  CreateAcountInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol CreateAcountInteractorInput {

}

protocol CreateAcountInteractorOutput: AnyObject {

}

final class CreateAcountInteractor: CreateAcountInteractorInput {
    weak var output: CreateAcountInteractorOutput!

}
