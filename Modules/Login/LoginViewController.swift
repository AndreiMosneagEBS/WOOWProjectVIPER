//
//  LoginViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol LoginViewInput: AnyObject {
	func setupInitialState()
}

protocol LoginViewOutput {
    func viewIsReady()
    func didTapCreateAccount()
    func didTapLoginButton(email:String, pasword: String)
    func failedLogin()-> String
}

final class LoginViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "Login"
	
    var presenter: LoginViewOutput!
    var moduleInput: LoginModuleInput!
    
    @IBOutlet weak var nameProfile: UITextField!
    @IBOutlet weak var passwordProfile: UITextField!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var login: UIButton!
    
    
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if presenter == nil {
        	LoginViewController.configureVIPERModule(for: self)
		}
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if presenter == nil {
			LoginViewController.configureVIPERModule(for: self)
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        
    }
    
    
    
    // MARK: - Action
    
    @IBAction func createAccoutAction(_ sender: Any) {
        print("ok")
        self.presenter.didTapCreateAccount()
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        self.presenter.didTapLoginButton(email: nameProfile.text!, pasword: passwordProfile.text!)
        
    }
}

// MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {
	func setupInitialState() {

    }
}
