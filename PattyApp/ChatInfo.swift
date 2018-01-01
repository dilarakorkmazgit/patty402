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
                
                user.userId = dictionary["userId"] as! String
                user.firstname = dictionary["firstname"] as! String
                user.lastname = dictionary["lastname"] as! String
                user.email = dictionary["email"] as! String

                
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
        
       // let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        
        cell.textLabel?.text = "\(user.firstname!) \(user.lastname!)"
        cell.detailTextLabel?.text = user.email
        cell.imageView?.image = UIImage(named: "mail")
        return cell
 }
    class UserCell: UITableViewCell {
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("not implemented")
        }
    }
    
}
