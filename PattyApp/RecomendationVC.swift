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

class RecomendationVC: RootViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var VetNameLabel: UILabel!
    @IBOutlet var TableViewForVet: UITableView!
    let userid = Auth.auth().currentUser?.uid
    var ref = Database.database().reference()
    var storageRef = Storage.storage().reference()
    
    let cellPets = "cellPets"
    
    var pets = [Pet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewForVet.register(UserCell.self, forCellReuseIdentifier: cellPets)
        
        self.title = "Önerilenler"
        self.TableViewForVet.delegate = self
        self.TableViewForVet.dataSource = self
        
        observeAllPets()
        
        
    }
    
    
    
    func observeAllPets(){
        
        let userid = Auth.auth().currentUser?.uid
        var userIDPetTur = ""
        var userIDPetHealth = ""
        var userIDPetAge = 0
        
        Database.database().reference().child("user").child(userid!).child("pet").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            userIDPetTur = value?["tur"] as? String ?? ""
            
            
        } , withCancel: nil)
        
        Database.database().reference().child("user").child(userid!).child("pet").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            userIDPetHealth = value?["health"] as? String ?? ""
            
            
        } , withCancel: nil)
        
        Database.database().reference().child("user").child(userid!).child("pet").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            userIDPetAge = value?["age"] as? Int ?? 0
            
            
        } , withCancel: nil)
        
        
        Database.database().reference().child("user").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let pet = Pet()
                
                pet.tur = dictionary["pet"]!["tur"] as? String
                pet.age = dictionary["pet"]!["age"] as? Int
                pet.petname = dictionary["pet"]!["petName"] as? String
                
                
                if(userIDPetTur == pet.tur) {
                    self.pets.append(pet)
                    
                }
                
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
        
        return pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = TableViewForVet.dequeueReusableCell(withIdentifier: cellPets, for: indexPath) as! UserCell
        
        
        let pet = self.pets[indexPath.row]
        
        cell.textLabel?.text = pet.petname
        cell.detailTextLabel?.text = pet.tur
        
        if let profileImageUrl = pet.photo {
            
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        return cell
    }
    
}
