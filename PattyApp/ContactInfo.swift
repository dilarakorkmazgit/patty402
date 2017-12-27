//
//  ContactInfo.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 27.12.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase

class ContactInfo: UITableViewController {
    
    
    let cellId = "cellId"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(handleCancel))
        
        fetchUser()
    }
    func fetchUser() {
        
        Database.database().reference().child("user").observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: Any] {
                let user = User()
                user.setValuesForKeys(dictionary)
                self.users.append(user)
               
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()

                })
                
            }
            
            
            
        }, withCancel: nil)
    }
    
    func handleCancel() {
        
        
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
       
        let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.email
        
        cell.textLabel?.text = "Dummy"
        
        return cell
    }
}
