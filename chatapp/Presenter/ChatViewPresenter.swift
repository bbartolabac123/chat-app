//
//  ChatViewPresenter.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/12/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import Foundation

protocol ChatViewPresenter: class {
    init(view: ChatView)
    func loadData()
    func sendBtnAction(withMessage message: String, andSender sender: String)
}


class ChatPresenter: ChatViewPresenter {
    
  
    weak var view : ChatView?
    let service = FireStoreService.sharedInstance
   
    required init(view: ChatView) {
        self.view = view
    }
    
    func sendBtnAction(withMessage message: String, andSender sender: String) {
        
        service.addMessage(message: message, sender: sender, completionHandler: { message in
              self.loadData()
        }) { error in
            
        }
        
    }
    
    func loadData() {
        
        service.loadMessages(completionHandler: { messages in
            self.view?.loadMessages(message: messages)
        }) { err in
            
        }
    }
}
