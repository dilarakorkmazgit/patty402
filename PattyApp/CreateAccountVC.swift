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

class CreateAccountVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    

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






}
