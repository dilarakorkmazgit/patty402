//
//  VeterineryViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 13/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class VeterineryViewController: RootViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var VetNameLabel: UILabel!
    
    @IBOutlet weak var TableViewForVet: UITableView!
    
    
    let cellVet = "cellVet"
    
    var vet = [Veterinery]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewForVet.register(UserCell.self, forCellReuseIdentifier: cellVet)
        
        self.title = "Veteriner"
        self.TableViewForVet.delegate = self
        self.TableViewForVet.dataSource = self
        
        observeAllUser()
        
        
    }
    func observeAllUser(){
        
        Database.database().reference().child("Veterinery").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let vet = Veterinery()
                
                vet.address = dictionary["Address"] as? String
                //vet.calender = dictionary["Calender"] as? String
                vet.Name = dictionary["Name"] as? String
                vet.phone = dictionary["Phone"] as? Int
                vet.photo = dictionary["Photo"] as? String
                print(snapshot)
                
                self.vet.append(vet)
                
                DispatchQueue.main.async(execute: {
                    self.TableViewForVet.reloadData()
                })
            }
            
        } , withCancel: nil)
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
     
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return vet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableViewForVet.dequeueReusableCell(withIdentifier: cellVet, for: indexPath) as! UserCell

        
        let vet = self.vet[indexPath.row]
        
        cell.textLabel?.text = vet.Name
        cell.detailTextLabel?.text = vet.address
       
        if let profileImageUrl = vet.photo {
            
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        return cell
    }
    
    
}
