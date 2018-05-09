//
//  SahipsizVC.swift
//  PattyApp
//
//  Created by Burak Nurcicek on 3.05.2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SahipsizVC: RootViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var sahipsizTableView: UITableView!
    let cellSahipsizPet = "cellSahipsizPet"
    
    var sahipsizPet = [SahipsizPet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sahipsizTableView.register(UserCell.self, forCellReuseIdentifier: cellSahipsizPet)
        
        self.title = "Sahiplen"
        self.sahipsizTableView.delegate = self
        self.sahipsizTableView.dataSource = self
        
        observeAllPets()
        
        
    }
    func observeAllPets(){
        
        Database.database().reference().child("Ownerless").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let sahipsizPet = SahipsizPet()
                
                sahipsizPet.petHome = dictionary["petHome"] as? String
                //vet.calender = dictionary["Calender"] as? String
                sahipsizPet.name = dictionary["Name"] as? String
                sahipsizPet.photo = dictionary["Photo"] as? String
                print(snapshot)
                
                self.sahipsizPet.append(sahipsizPet)
                
                DispatchQueue.main.async(execute: {
                    self.sahipsizTableView.reloadData()
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
        
        return sahipsizPet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = sahipsizTableView.dequeueReusableCell(withIdentifier: cellSahipsizPet, for: indexPath) as! UserCell
        
        
        let sahipsizPet = self.sahipsizPet[indexPath.row]
        
        cell.textLabel?.text = sahipsizPet.name
        cell.detailTextLabel?.text = sahipsizPet.petHome
        
        if let profileImageUrl = sahipsizPet.photo {
            
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        return cell
    }
    
    
}
