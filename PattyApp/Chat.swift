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
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Çıkış", style: .plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "new_message_icon")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(newMessage))
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showChatController))
        
        checkIfUserIsLoggedIn()
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        //observeMessage()
        observeUserMessages()
        
    }
    
    var messages = [Message] ()
    var messagesDictionary = [String: Message]()
    var users = [User] ()
    
    func observeUserMessages() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
            
        }
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: {(snapshot) in
            
            let messageId = snapshot.key
            let messageReference = Database.database().reference().child("messages").child(messageId)
            
            messageReference.observe(.value, with: {(snapshot) in
                
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    let message = Message()
                    
                    
                    message.text = dictionary["text"] as! String
                    message.toId = dictionary["toId"] as! String
                    
                    
                    //  self.messages.append(message)
                    
                    if let toId = message.toId {
                        
                        self.messagesDictionary[toId] = message
                        self.messages = Array(self.messagesDictionary.values)
                        
                        
                        /*self.messages.sort(by: { (message1, message2) ->
                         Bool in
                         
                         return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                         })*/
                        
                    }
                    
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }

                
            }, withCancel: nil)
            
            
        }, withCancel: nil)
        
        
    }
    func observeMessage() {
        
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let message = Message()
                
                
                message.text = dictionary["text"] as! String
                message.toId = dictionary["toId"] as! String
                
                
              //  self.messages.append(message)
                
                if let toId = message.toId {
                    
                    self.messagesDictionary[toId] = message
                    self.messages = Array(self.messagesDictionary.values)
                  
                    
                    /*self.messages.sort(by: { (message1, message2) ->
                        Bool in
                        
                        return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                    })*/
                
                }
                
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let message = messages[indexPath.row]
        
        cell.message = message
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = messages[indexPath.row]
        
        print(message.text, message.toId, message.fromId)
    
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
