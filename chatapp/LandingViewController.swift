//
//  LandingViewController.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/12/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var signUPBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUPBtn.backgroundColor = .darkGreen
        loginBtn.backgroundColor = .lightGreen
        
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "userview") as! UserViewController
        self.navigationController?.pushViewController(vc, animated: false)
    
    }
    
    @IBAction func logInAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "loginview") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}


extension UIColor{
    
    static var lightGreen :UIColor {
        return UIColor(red: CGFloat(136) / 255, green: CGFloat(227) / 255, blue: CGFloat(6) / 255, alpha: 1.0)
    }
    
    static var darkGreen:UIColor {
        return UIColor(red: CGFloat(98) / 255, green: CGFloat(163) / 255, blue: CGFloat(4) / 255, alpha: 1.0)
    }
}
