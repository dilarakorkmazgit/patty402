//
//  Chat.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 31.12.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase

class Chat: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Çıkış", style: .plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "write")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(newMessage))
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showChatController))
        
        checkIfUserIsLoggedIn()
        observeMessage()
    }
    var messages = [Message] ()
    var users = [User] ()
    
    func observeMessage() {
        
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let message = Message()
                
                
                message.text = dictionary["text"] as! String
                message.toId = dictionary["toId"] as! String
                
                
                self.messages.append(message)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        let message = messages[indexPath.row]
        if let toId = message.toId {
            
          let ref =  Database.database().reference().child("locations").child(toId)
            
            ref.observe(.value, with: {(snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let user = User()
                    user.firstname = dictionary["firstname"] as! String
                    user.lastname = dictionary["lastname"] as! String

                    
                    cell.textLabel?.text = "\(user.firstname!) \(user.lastname!)"
                    
                }
                
            } , withCancel: nil)
            
        }
        
        
        
        cell.detailTextLabel?.text = message.text
        
        return cell
    }
    
    func newMessage() {
        
        let chatInfo = ChatInfo()
        chatInfo.messagesController = self
        let navController = UINavigationController(rootViewController: chatInfo)
        present(navController, animated: true, completion: nil)
        
    }
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("user").child(uid!).child("personalInfo").observe(.value, with: {(snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    self.navigationItem.title = dictionary["firstname"] as? String
                }
                
                print(snapshot)
            } , withCancel: nil)
        }
    }
    func showChatControllerForUser(user: User) {
        
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        
        chatLogController.user = user
        navigationController?.pushViewController(chatLogController, animated: true)
        
        
    }
    
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
            print("çıkış yapıldı")
            
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(loginVC, animated: true, completion: nil)
    }
}
