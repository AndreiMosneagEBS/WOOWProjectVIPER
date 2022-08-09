//
//  LoginInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol LoginInteractorInput {

}

protocol LoginInteractorOutput: AnyObject {

}

final class LoginInteractor: LoginInteractorInput {
    weak var output: LoginInteractorOutput!

}
