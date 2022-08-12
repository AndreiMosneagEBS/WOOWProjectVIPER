//
//  FavoritesInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol FavoritesInteractorInput {

}

protocol FavoritesInteractorOutput: AnyObject {

}

final class FavoritesInteractor: FavoritesInteractorInput {
    weak var output: FavoritesInteractorOutput!

}
