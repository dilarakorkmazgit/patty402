//
//  LoginVC.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 18.10.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginPressed(_ sender: Any) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
                if error == nil {
                    print("correct")
                    
                }else {
                    Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
                        if error == nil {
                            print("invalid")
                        }else {
                             print("success")
                        }
                }
            
       }


    
    }

}

    }
}
