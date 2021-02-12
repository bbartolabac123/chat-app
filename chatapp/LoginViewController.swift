//
//  LoginViewController.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/12/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import UIKit

protocol LoginViews: class {
    func onLoginSuccess(message: String)
    func onLoginFailure(message: String)
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errLbl1: UILabel!
    @IBOutlet weak var errLbl2: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Chat App"
        
        loginBtn.backgroundColor = .lightGreen
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let username = self.usernameTxt.text ?? ""
        let password = self.passwordTxt.text ?? ""
               
       if username.count == 0 {
           self.errLbl1.isHidden = false
           self.errLbl1.text = "Value is incorrect"
       }else if password.count == 0 {
           self.errLbl2.isHidden = false
           self.errLbl2.text = "Value is incorrect"
       }else {
           presenter.loginBtnAction(withUsername: username, andPassword: password)
       }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "userview") as! UserViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension LoginViewController: LoginViews {
    
    func onLoginSuccess(message: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "chatview") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func onLoginFailure(message: String) {
        self.errLbl1.isHidden = false
        self.errLbl1.text = "Value is incorrect"
        
        self.errLbl2.isHidden = false
        self.errLbl2.text = "Value is incorrect"
    }
}
