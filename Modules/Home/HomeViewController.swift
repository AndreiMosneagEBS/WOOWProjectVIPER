//
//  HomeViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 26/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import EBSSwiftUtils
import FBSDKCoreKit
import FBSDKLoginKit

protocol HomeViewInput: AnyObject {
	func setupInitialState()
    func googleLogin()
}

protocol HomeViewOutput {
    func viewIsReady()
    func didTapGoogleLogin()
    func didTapFacebookLogin()
    func didTapAppleLogin()


}

final class HomeViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "Home"
	
    var presenter: HomeViewOutput!
    var moduleInput: HomeModuleInput!
    
    @IBOutlet weak var loginGoogle: GIDSignInButton!
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var loginApple: UIButton!
    
    

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if presenter == nil {
        	HomeViewController.configureVIPERModule(for: self)
		}
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if presenter == nil {
			HomeViewController.configureVIPERModule(for: self)
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
       
    }
    
    @IBAction func googleLoginAction(_ sender: UIButton) {
        let signInConfig = GIDConfiguration.init(clientID: "958729113915-kbifijitve5ffr6volduab18r2v4dabk.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self)
        self.presenter.didTapGoogleLogin()
    }
    
    @IBAction func facebookLoginAction(_ sender: Any) {
        self.presenter.didTapFacebookLogin()
    }
    
    @IBAction func appleLoginAction(_ sender: Any) {
        self.presenter.didTapAppleLogin()
        
    }
    
    
    
    
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {
    func googleLogin() {
        print("login")
    }
    
	func setupInitialState() {

    }
}
