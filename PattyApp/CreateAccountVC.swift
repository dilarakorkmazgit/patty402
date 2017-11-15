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

//create databse reference
let databaseRef = Database().reference();


class CreateAccountVC: UIViewController {


    static let ds = CreateAccountVC()
   
    //create private variable for tuples
    private var _databaseRef = databaseRef
    private var ref_User = databaseRef.child("user")
    
    var Refbase :DatabaseReference{
        
        
        return _databaseRef
        
    }
    
    var Refuser :DatabaseReference{
        
        
        return ref_User
        
    }
    func newFirebaseuser(){
        
    }
    
    
    
    

    @IBOutlet weak var firstnameLabel: UITextField!
    @IBOutlet weak var lastnameLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var mailLabel: UITextField!
    @IBOutlet weak var poasswordLabel: UITextField!
    @IBOutlet weak var kaydolButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "LoggedInVC", sender: nil)
    }
    
    @IBAction func kaydolPressed(_ sender: Any) {
        
        
        
        
    }
    
    

}
