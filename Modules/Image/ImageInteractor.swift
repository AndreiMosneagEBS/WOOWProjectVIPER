//
//  ImageInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 02/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol ImageInteractorInput {

}

protocol ImageInteractorOutput: AnyObject {

}

final class ImageInteractor: ImageInteractorInput {
    weak var output: ImageInteractorOutput!

}
