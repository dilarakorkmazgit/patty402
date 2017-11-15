//
//  CreateAccountViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 18/10/2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase



class CreateAccountVC: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var firstnameLabel: UITextField!
    @IBOutlet weak var lastnameLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var mailLabel: UITextField!
    @IBOutlet weak var poasswordLabel: UITextField!
    @IBOutlet weak var kaydolButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

         ref = Database.database().reference().child("user")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func kaydolPressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: mailLabel.text!, password: poasswordLabel.text!, completion: {(user,error) in
            
            
            if error != nil {
                print(error)
                return
            }
            
            
            let userID: String = user!.uid
            let firstname: String = self.firstnameLabel.text!
            let lastname: String = self.lastnameLabel.text!
            let email: String = self.mailLabel.text!
            let username: String = self.usernameLabel.text!
            let password: String = self.poasswordLabel.text!
            
            self.ref.child(userID).setValue(["firstname": firstname, "lastname": lastname, "email": email, "password":password, "username": username])
            print("user registered" + user!.uid)
            
        })
        self.performSegue(withIdentifier: "LoggedInVC", sender: nil)


    }
    

}




