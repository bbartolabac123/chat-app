//
//  UserViewController.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/11/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import UIKit

protocol UserViews: class {
    func onRegisterSuccess(message: String)
    func onRegisterFailure(message: String)
}

class UserViewController: UIViewController {
        
    var presenter: UserPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UserPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Chat App"
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        let username = self.usernameText.text ?? ""
        let password = self.passwordText.text ?? ""
        
        if username.count == 0 {
            self.error1.isHidden = false
            self.error1.text = "Value is incorrect"
        }else if password.count == 0 {
            self.error2.isHidden = false
            self.error2.text = "Value is incorrect"
        }else {
           presenter.registerBtnAction(with: username, and: password)
        }
    }
   
    @IBAction func loginBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "loginview") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBOutlet weak var error1: UILabel!
    @IBOutlet weak var error2: UILabel!

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

}


extension UserViewController: UserViews {
    
    func onRegisterFailure(message: String) {
        self.error1.isHidden = true
        self.error1.text = "Value is incorrect"
    }
    
    func onRegisterSuccess(message: String) {
        let alert = UIAlertController(title: "Alert", message: "You have successfully sign-up", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "loginview") as! LoginViewController
                      self.navigationController?.pushViewController(vc, animated: false)
            })
        )
        self.present(alert, animated: true, completion: nil)
    }
}

