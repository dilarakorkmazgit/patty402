//
//  ChatInfo.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 31.12.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase

class ChatInfo: UITableViewController {
    
    let cellId = "cellId"
    var users = [User] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Geri", style: .plain, target:self, action: #selector(handleCancel))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        fetchUser()
    }
    func handleCancel() {
        
        dismiss(animated: true, completion: nil)
        
    }
    func fetchUser() {
        
        Database.database().reference().child("locations").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                
                user.userId = dictionary["userId"] as? String
                user.firstname = dictionary["firstname"] as! String
                user.lastname = dictionary["lastname"] as! String
                user.email = dictionary["email"] as! String
                user.photo = dictionary["photo"] as! String
                
                
                self.users.append(user)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        } , withCancel: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        
        cell.textLabel?.text = "\(user.firstname!) \(user.lastname!)"
        cell.detailTextLabel?.text = user.email
      
        
        if let profileImageUrl = user.photo {
           
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    var messagesController: Chat?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        dismiss(animated: true) {
            
            let user = self.users[indexPath.row]
            self.messagesController?.showChatControllerForUser(user: user)
        }
    
    }
  
       
}
