//
//  FilterTableViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 12/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FilterTableViewController: RootViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var petNameLabel: UILabel!
   
    @IBOutlet weak var tableViewForPet: UITableView!
  
    
    let cellPets = "cellPets"
    
    var pets = [Pet]()

    func observeAllUser(){
        
        
        Database.database().reference().child("user").observe(.childAdded, with: {(snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                //print(dictionary["pet"])
                let petInfo = Pet()
                print("ggggjh")

                // get pet info
               
                    print("geldiiiii")

                petInfo.petname = dictionary["pet"]!["petName"] as? String
                petInfo.gendery = dictionary["pet"]!["gender"] as? String
                petInfo.tur = dictionary["pet"]!["tur"] as? String
                petInfo.age = dictionary["pet"]!["age"] as? Int
                petInfo.color = dictionary["pet"]!["color"] as? String
                petInfo.health = dictionary["pet"]!["health"] as? String
                petInfo.photo = dictionary["pet"]!["photo"] as? URL

                self.pets.append(petInfo)
                
                print("ggh")
               
                
                
                 DispatchQueue.main.async(execute: {
                    self.tableViewForPet.reloadData()
                 })
                }
            
        }, withCancel: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filtre"
        self.tableViewForPet.delegate = self
        self.tableViewForPet.dataSource = self
      
        observeAllUser()

        
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return pets.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle,reuseIdentifier: cellPets)
        
        
        cell.textLabel?.text = pets[indexPath.row].petname
        
        return cell
    }


}
