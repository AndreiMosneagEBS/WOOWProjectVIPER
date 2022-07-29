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
        super.viewDidLoad()
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 12, green: 24, blue: 89, alpha: 100)
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
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
