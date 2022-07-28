//
//  BaseVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 27.07.2022.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import Firebase
import UIKit
import ProgressHUD

class BaseVC: UIViewController {
    
}


extension BaseVC {

    func showHud() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorAnimation = UIColor.blue
        ProgressHUD.show(nil, interaction: false)
    }

    func hideHud() {
        ProgressHUD.dismiss()
    }

    func hideHudWithSuccess() {
        ProgressHUD.show(icon: .succeed)
    }

    func hideHudWithError() {
        ProgressHUD.show(icon: .failed)
    }

    func showFailureHudWith(text: String) {
        ProgressHUD.showFailed(text)
    }
    
    func showSuccessHudWith(text: String) {
        ProgressHUD.showSucceed(text)
    }
}
