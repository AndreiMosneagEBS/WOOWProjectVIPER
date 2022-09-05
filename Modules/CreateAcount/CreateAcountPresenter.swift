//
//  CreateAcountPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Firebase
protocol CreateAcountModuleInput: AnyObject {
    
}

final class CreateAcountPresenter {
    weak var view: CreateAcountViewInput!
    
    var interactor: CreateAcountInteractorInput!
    var router: CreateAcountRouterInput!
    var nameUser: String = ""
    var passwordUser: String = ""
    var repeatPassword: String = ""
    
    
    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
    
    private func validateFields()-> String? {
        if nameUser.isEmpty , passwordUser.isEmpty, repeatPassword.isEmpty, passwordUser != repeatPassword {
            
            // need alert control
            return " Sunt goale sau nu sunt asemanatoare"
        }
        
        if nameUser.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordUser.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordUser.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return nil
        }
        
        return nil
    }
}

// MARK: - CreateAcountModuleInput

extension CreateAcountPresenter: CreateAcountModuleInput {
    
}

// MARK: - CreateAcountViewOutput

extension CreateAcountPresenter: CreateAcountViewOutput {
    
    func didTapSignUp(name: String, password: String, repetePassword: String) {
        self.nameUser = name
        self.passwordUser = password
        self.repeatPassword = repetePassword
        
        let error = validateFields()
        if error != nil {
            // arata o alerta
            print("error != nill")
        } else {
            
            let firstName = nameUser.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordUser.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create user
            
            
            
            Auth.auth().createUser(withEmail: (firstName), password: (password)) { (result, error) in
                if let _eror = error {
                    //something bad happning
                    print(_eror.localizedDescription )
                }else{
                    //user registered successfully
                    print(result)
                    self.router.didTapSignUp()
                }
            }
        }
    }

    func viewIsReady() {
        view.setupInitialState()
    }
}

// MARK: - CreateAcountInteractorOutput

extension CreateAcountPresenter: CreateAcountInteractorOutput {
    
}
