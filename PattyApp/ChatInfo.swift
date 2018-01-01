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
        
       // let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        
        cell.textLabel?.text = "\(user.firstname!) \(user.lastname!)"
        cell.detailTextLabel?.text = user.email
       // cell.imageView?.image = UIImage(named: "mail")
       // cell.imageView?.contentMode = .scaleAspectFill
        
        if let profileImageUrl = user.photo {
            let url = NSURL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async(execute: {
         //           cell.imageView?.image = UIImage(data: data!)
                })
            }).resume()
            
        }
        
        
        return cell
 }
    class UserCell: UITableViewCell {
        
        override func layoutSubviews() {
            
            super.layoutSubviews()
          
            textLabel?.frame = CGRectMake(56, textLabel!.frame.origin.y, textLabel!.frame.width, textLabel!.frame.height)
            detailTextLabel?.frame = CGRectMake(56, detailTextLabel!.frame.origin.y, detailTextLabel!.frame.width, textLabel!.frame.height)
       
        }
        
        func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
            return CGRect(x: x, y: y, width: width, height: height)
        }
        
        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "mail")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            
            addSubview(profileImageView)
            
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("not implemented")
        }
    }
    
}
