//
//  Contact.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 27.12.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase

class Contact: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserLoggedIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            
       //     performSelector(#selector(handleLogout), with: nil, afterDelay:0)
        }else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
                if let dictionary = snapshot.value as? [String: Any] {
                    
                    self.navigationItem.title = dictionary["username"] as? String
                
                    
                }
             //   self.navigationItem.title = ???
                
                
                
                
            }, withCancel: nil)
        }
        
    }
    func handleLogout() {
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
     //   let loginController = LoginController()
       // presentViewController(loginController, animated: true, completion:nil)
    }
    
}
