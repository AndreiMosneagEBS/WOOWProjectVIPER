//
//  ProfileViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 03/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol ProfileViewInput: AnyObject {
    func setupInitialState()
}

protocol ProfileViewOutput {
    func viewIsReady()
}

final class ProfileViewController: BaseVC, StoryboardInstantiable {
    static var storyboardName: String = "Profile"
    
    var presenter: ProfileViewOutput!
    var moduleInput: ProfileModuleInput!
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if presenter == nil {
            ProfileViewController.configureVIPERModule(for: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if presenter == nil {
            ProfileViewController.configureVIPERModule(for: self)
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        setLayout()
        setup()
    }
    
    func setLayout() {
        imageProfile.cornerRadius = imageProfile.frame.width / 2
        logoutButton.cornerRadius = 2
        
        
    }
    func setup() {
        if let image = UserSession.share.image {
            imageProfile.image = image
        }
        if let name = UserSession.share.name {
            nameProfile.text = name
        }
    }
    
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    func setupInitialState() {
        
    }
}
