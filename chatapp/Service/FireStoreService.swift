//
//  Repository.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/12/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol serviceHandler {
    func getUsers(username: String, completionHandler: @escaping ([User]) -> (), failHandler: @escaping (Error) -> ())
    func getUser(withUsername username: String, andPassword password: String,  completionHandler: @escaping ([User]) -> (), failHandler: @escaping (Error) -> ())
    func addUser(username: String, password: String, completionHandler: @escaping (String) -> (), failHandler: @escaping (Error) -> () )
    func addMessage(message: String, sender: String, completionHandler: @escaping (String) -> (), failHandler: @escaping (Error) -> ())
    func loadMessages(completionHandler: @escaping ([Message]) -> (), failHandler: @escaping (Error) -> ())
}


class FireStoreService: serviceHandler {

    
    let db = Firestore.firestore()
    static let sharedInstance:FireStoreService = FireStoreService.init()
       
    private init() {}
    
    func getUsers(username: String, completionHandler: @escaping ([User]) -> (), failHandler: @escaping (Error) -> ()) {
        
        db.collection("users").whereField("username", isEqualTo: username).getDocuments() { (querySnapshot, err) in
                             
                 guard let documents = querySnapshot?.documents else {
                      print("No documents")
                      failHandler(err!)
                      return
                 }
                 
                let users = documents.compactMap { queryDocumentSnapshot -> User? in
                      return try? queryDocumentSnapshot.data(as: User.self)
                 }
           
                completionHandler(users)
       }
    }
    
    
    func getUser(withUsername username: String, andPassword password: String, completionHandler: @escaping ([User]) -> (), failHandler: @escaping (Error) -> ()) {
        
        db.collection("users").whereField("username", isEqualTo: username).whereField("password", isEqualTo: password).getDocuments() { (querySnapshot, err) in
                               
                   guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        failHandler(err!)
                        return
                   }
                   
                  let users = documents.compactMap { queryDocumentSnapshot -> User? in
                        return try? queryDocumentSnapshot.data(as: User.self)
                   }
             
                  completionHandler(users)
         }
    }
    
    
    func addUser(username: String, password: String, completionHandler: @escaping (String) -> (), failHandler: @escaping (Error) -> ()) {
        
        var ref: DocumentReference? = nil
         ref = self.db.collection("users").addDocument(data: [
              "username": username,
              "password": password,
          ]) { err in
              if let err = err {
                  failHandler(err)
              } else {
                  completionHandler("Document added with ID: \(ref!.documentID)")
              }
          }
    }
    
    func addMessage(message: String, sender: String, completionHandler: @escaping (String) -> (), failHandler: @escaping (Error) -> ()) {
          var ref: DocumentReference? = nil
              ref = self.db.collection("messages").addDocument(data: [
                   "message": message,
                   "sender": sender,
                   "created_at" : Timestamp(date: Date())
               ]) { err in
                   if let err = err {
                       failHandler(err)
                   } else {
                       completionHandler("Document added with ID: \(ref!.documentID)")
                   }
               }
    }
    
    func loadMessages(completionHandler: @escaping ([Message]) -> (), failHandler: @escaping (Error) -> ()) {
        db.collection("messages").order(by: "created_at", descending: false).getDocuments() { (querySnapshot, err) in
                                      
              guard let documents = querySnapshot?.documents else {
                   print("No documents")
                   failHandler(err!)
                   return
              }
              
             let messages = documents.compactMap { queryDocumentSnapshot -> Message? in
                   return try? queryDocumentSnapshot.data(as: Message.self)
              }
        
             completionHandler(messages)
        }
    }
}
