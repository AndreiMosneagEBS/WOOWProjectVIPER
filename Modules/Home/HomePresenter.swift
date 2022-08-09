//
//  HomePresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Andrei on 26/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import SwiftyJSON
import UIKit


protocol HomeModuleInput: AnyObject {
    func didLoginGoogleSucces()
    func didLoginGoogleFailure(error: Error)
}

final class HomePresenter {
    weak var view: HomeViewInput!
	
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!

    private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
    
    
}

// MARK: - HomeModuleInput

extension HomePresenter: HomeModuleInput {

}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {
    func didTapGuest() {
        self.router.didTapGuest()
    }
    
    
    func didTapGoogleLogin() {
        let config = GIDConfiguration.init(clientID: "958729113915-kbifijitve5ffr6volduab18r2v4dabk.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self.baseVC) { user, error in
            self.view.googleLogin()

          if let error = error {
              print(error.localizedDescription)
            return
          }
            self.router.didTapLogIn()
            
            DispatchQueue.global().async {
                UserSession.share.name = user?.profile?.name
                UserSession.share.email = user?.profile?.email
                guard let userImage = user?.profile?.imageURL(withDimension: 30) else{
                    return
                }
                if let data = try? Data (contentsOf: userImage) {
                    if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        UserSession.share.image = image
                        
                        }
                    }
                }
            }
        }
    }
    
    func didTapFacebookLogin() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: baseVC) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                self.getFacebookProfileInfo()
                self.router.didTapLogIn()
            }
        }
    }
    
    func getFacebookProfileInfo() {
        let requestMe = GraphRequest.init(graphPath: "me", parameters: ["fields" : "id,name,email,picture.type(large)"])

        let connection = GraphRequestConnection()

        connection.add(requestMe, completion:{ (connectn, userresult, error) in
            guard let userResult = userresult else {
                return
            }
            DispatchQueue.global().async { 
                let userJson = JSON(userResult)
                UserSession.share.name = userJson["name"].stringValue
                let image = userJson["picture","data","url"].stringValue
                let fileURL = URL(string: image)
                if let data = try? Data (contentsOf: fileURL!) {
                    if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        UserSession.share.image = image
                        }
                    }
                }
            }
          })
          connection.start()
      }
    func shareUserData() {
        
    }
    func didTapAppleLogin() {
        
    }
    func viewIsReady() {
        view.setupInitialState()
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
    func didLoginGoogleSucces() {
        self.router.showProfileView()
    }
    
    func didLoginGoogleFailure(error: Error) {
//        print(T##items: Any...##Any)
    }
}
