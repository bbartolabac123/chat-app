//
//  UserViewPresenter.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/11/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import Foundation

protocol UserViewPresenter: class {
    init(view: UserViews)
    func registerBtnAction(with username: String, and password: String)
}


class UserPresenter: UserViewPresenter {
  
    weak var view : UserViews?
    let service = FireStoreService.sharedInstance
   
    required init(view: UserViews) {
        self.view = view
    }
 
    func registerBtnAction(with username: String, and password: String) {
       registerUser(username: username, password: password)
    }
    
    private func registerUser(username: String, password: String) {
        
        service.getUsers(username: username, completionHandler: { users in
            
            
            if users.count == 0 {
                
                self.service.addUser(username: username, password: password, completionHandler: { message in
                    self.view?.onRegisterSuccess(message: "Success")
                }) { error in
                    self.view?.onRegisterFailure(message: "Error")
                }
                
            }else {
                
                self.view?.onRegisterFailure(message: "Duplicate")
                
            }
        }) { err in
            self.view?.onRegisterFailure(message: "Error")
        }
            
    }
    
}
