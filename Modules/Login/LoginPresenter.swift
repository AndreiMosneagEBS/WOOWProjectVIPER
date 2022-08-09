//
//  LoginPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol LoginModuleInput: AnyObject {
    
}

final class LoginPresenter {
    weak var view: LoginViewInput!
    
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
}

// MARK: - LoginModuleInput

extension LoginPresenter: LoginModuleInput {
    
}

// MARK: - LoginViewOutput

extension LoginPresenter: LoginViewOutput {
    func failedLogin() -> String {
        return "The email address or password is incorrect. Please retry"
    }
    
    func didTapLoginButton(email: String, pasword: String) {
        Auth.auth().signIn(withEmail: (email), password: (pasword)) { (result, error) in
            if let _eror = error{
                print(_eror.localizedDescription)
                self.failedLogin()
            }else{
                if let _res = result{
                    print(_res)
                    self.router.didTapLoginButton()
                }
            }
        }
    }
    
    func didTapCreateAccount() {
        self.router.didTapAccount()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

// MARK: - LoginInteractorOutput

extension LoginPresenter: LoginInteractorOutput {
    
}
