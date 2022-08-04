//
//  ProfileInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 03/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ProfileInteractorInput {

}

protocol ProfileInteractorOutput: AnyObject {

}

final class ProfileInteractor: ProfileInteractorInput {
    weak var output: ProfileInteractorOutput!

}
