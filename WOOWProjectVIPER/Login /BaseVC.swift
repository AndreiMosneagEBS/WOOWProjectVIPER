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
    
    override func viewDidLoad() {
        
    }
}

extension BaseVC {
    func showHud() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorAnimation = UIColor.orange
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
extension BaseVC {
    @IBAction func popToBack(_ sender: AnyObject? = nil) {
        NotificationCenter.default.removeObserver(self)
        if let navigation = self.navigationController,
           navigation.children.count > 1 {
            navigation.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
