//
//  Profile.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 24/12/2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit
import Firebase
import FirebaseDatabase
import SDWebImage

class Profile: UIViewController{
    
    let ref = Database.database().reference()
   
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var petNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width / 2
        ProfileImage.clipsToBounds = true
        ProfileImage.layer.borderColor = UIColor.white.cgColor
        
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
            
            self.ProfileImage.sd_setImage(with: URL(string: profileImageURL ), placeholderImage: UIImage(named: "placeholder.png"))
           
            self.petNameLabel.text = pattyName.description

            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        //fit the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BACKGROUND-1")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
}

