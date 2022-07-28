//
//  HomeInteractor.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 26/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

protocol HomeInteractorInput {
    
}

protocol HomeInteractorOutput: AnyObject {
  
}

final class HomeInteractor: HomeInteractorInput {
    
 weak var output: HomeInteractorOutput!
             
}
    
