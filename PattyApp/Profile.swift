//
//  Profile.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 24/12/2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import SDWebImage

class Profile: RootViewController{
    
    let ref = Database.database().reference()
   
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var update: UIButton!
    
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var goMap: UIButton!
    
    @IBOutlet weak var pertGenderLabel: UILabel!
    
    @IBOutlet weak var petAgeLabel: UILabel!
    
    @IBOutlet weak var petColorLabel: UILabel!
    
    @IBOutlet weak var petHealthLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profil"
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width / 2
        ProfileImage.clipsToBounds = true
        ProfileImage.layer.borderColor = UIColor.white.cgColor
        
        let size = CGSize(width: 5, height: 5)
        
        userNameLabel.layer.shadowOffset = size
        userNameLabel.layer.shadowRadius = 5
        userNameLabel.layer.shadowColor = UIColor.black.cgColor
        userNameLabel.layer.shadowOpacity = 0.5
        petNameLabel.layer.shadowOffset = size
        petNameLabel.layer.shadowRadius = 5
        petNameLabel.layer.shadowColor = UIColor.black.cgColor
        petNameLabel.layer.shadowOpacity = 0.5
        update.layer.shadowOffset = size
        update.layer.shadowRadius = 5
        update.layer.shadowColor = UIColor.black.cgColor
        update.layer.shadowOpacity = 0.5
        goMap.layer.shadowOffset = size
        goMap.layer.shadowRadius = 5
        goMap.layer.shadowColor = UIColor.black.cgColor
        goMap.layer.shadowOpacity = 0.5
      
        
        let userid = Auth.auth().currentUser?.uid
        
        //get currentuser username from firebase
        ref.child("user").child(userid!).child("personalInfo").observeSingleEvent(of: .value, with: { (snapshot) in
           
            // Get user value from current user
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            
            self.userNameLabel.text = username.description
            

            print(username)
            
        }) { (error) in
            print(error.localizedDescription)
        }
      
        //get currentuser profile image and pet name from firebase
        ref.child("user").child(userid!).child("pet").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Get user value from current user
            let value = snapshot.value as? NSDictionary
            let profileImageURL = value?["photo"] as? String ?? ""
            let pattyName = value?["petName"] as? String ?? ""
            let pattyType = value?["tur"] as? String ?? ""
            
            let pattyGender = value?["gender"] as? String ?? ""
            let pattyAge = value?["age"] as? String ?? ""
            let pattyColor = value?["color"] as? String ?? ""
            let pattyHealth = value?["health"] as? String ?? ""

            
            
            self.ProfileImage.sd_setImage(with: URL(string: profileImageURL ), placeholderImage: UIImage(named: "placeholder.png"))
           
            self.petNameLabel.text = pattyName.description
            self.petTypeLabel.text = pattyType.description
            self.pertGenderLabel.text = pattyGender.description
            self.petAgeLabel.text = pattyAge.description
            self.petColorLabel.text = pattyColor.description
            self.petHealthLabel.text = pattyHealth.description

            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        //fit the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-profil")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
}

