//
//  ViewController.swift
//  chatapp
//
//  Created by  Benjamin Bartolabac	 on 2/11/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import UIKit

protocol ChatView: class {
    func loadMessages(message: [Message])
}

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var presenter: ChatPresenter!
    var listOfmessages: [Message] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter = ChatPresenter(view: self)
        presenter.loadData()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Chat App"
        
        let logoutBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
        logoutBtn.backgroundColor = .gray
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.layer.cornerRadius = 5
        logoutBtn.layer.borderWidth = 1
        logoutBtn.addTarget(self, action: #selector(logout), for: .touchUpInside)
     
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutBtn)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
         tableView.register(UINib(nibName: "RightChatTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell2")
    }

    @objc func logout() {
        
        defaults.removeObject(forKey: "username")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
           let vc = storyBoard.instantiateViewController(withIdentifier: "loginview") as! LoginViewController
           self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let message = textField.text ?? ""
        
        if message.count != 0 {
            
            presenter.sendBtnAction(withMessage: message, andSender: defaults.string(forKey: "username")!)
        }
        
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfmessages.count
    }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       let message = listOfmessages[indexPath.row]
    
       if message.sender == defaults.string(forKey: "username") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! RightChatTableViewCell
            cell.txtView.text = message.message
            cell.senderLbl.text = message.sender
            return cell
       }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ChatTableViewCell
            cell.txtView.text = message.message
            cell.userNameLbl.text = message.sender
            cell.txtView.sizeToFit()
            return cell
        }
    
   }
    
}

extension ViewController: ChatView {
    
    func loadMessages(message: [Message]) {
        listOfmessages = message
        self.textField.text = ""
        self.tableView.reloadData()
        
        //scroll to bottom
        let indexPath = NSIndexPath(row: self.listOfmessages.count-1, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
    }
}

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

}


