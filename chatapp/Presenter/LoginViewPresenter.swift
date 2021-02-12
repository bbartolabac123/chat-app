//
//  LoginViewPresenter.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/12/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol LoginViewProtocol: class {
    init(view: LoginViews)
    func loginBtnAction(withUsername: String, andPassword: String)
}

class LoginPresenter: LoginViewProtocol {
    
    weak var view: LoginViews?
    let service = FireStoreService.sharedInstance
    
    required init(view: LoginViews) {
        self.view = view
    }
    
    func loginBtnAction(withUsername: String, andPassword: String) {
        print("Here")
        doLogin(username: withUsername, password: andPassword)
    }
    
    private func doLogin(username: String, password: String) {
      
        service.getUser(withUsername: username, andPassword: password, completionHandler: { user in
            
            if user.count != 0 {
                let defaults = UserDefaults.standard
                defaults.set(user.first?.username, forKey: "username")
                self.view?.onLoginSuccess(message: "success")
            } else {
                 self.view?.onLoginFailure(message: "failure")
            }
            
        }) { err in
            self.view?.onLoginFailure(message: "failure")
        }
        
    }
    
}
