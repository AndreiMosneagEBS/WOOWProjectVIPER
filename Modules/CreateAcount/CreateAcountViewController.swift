//
//  CreateAcountViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 05/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol CreateAcountViewInput: AnyObject {
	func setupInitialState()
}

protocol CreateAcountViewOutput {
    func viewIsReady()
    func didTapSignUp(name: String, password: String, repetePassword: String)
}

final class CreateAcountViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "CreateAcount"
	
    var presenter: CreateAcountViewOutput!
    var moduleInput: CreateAcountModuleInput!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password : UITextField!
    @IBOutlet weak var repetePassword: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if presenter == nil {
        	CreateAcountViewController.configureVIPERModule(for: self)
		}
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if presenter == nil {
			CreateAcountViewController.configureVIPERModule(for: self)
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
    }
    
    // MARK: - Action
    
    @IBAction func createAccountAction(_ sender: Any) {
    // validate the fields
    // Create user
    // Transmission to login
        self.presenter.didTapSignUp(name: name.text!, password: password.text!, repetePassword: password.text!)
    }
}





// MARK: - CreateAcountViewInput

extension CreateAcountViewController: CreateAcountViewInput {
	func setupInitialState() {

    }
}

