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
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
     //   view.addGestureRecognizer(tap)
                // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
  //  @IBAction func goBack(_ sender: Any) {
  //      self.navigationController?.popViewController(animated: true)
 //   }
    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                if let firebaseError = error {
                    let dialog = UIAlertController(title: "Oturum açılamadı", message: "Oturum açılamıyor, kullanıcı adı ya da parola yanlış. Patty hesabı için kaydoldun mu?", preferredStyle: UIAlertControllerStyle.alert)
                    dialog.addAction(UIAlertAction(title: "TAMAM", style: UIAlertActionStyle.default, handler: nil))
                    DispatchQueue.main.async(execute: {
                        self.present(dialog, animated: true, completion: nil)
                    })
                    print(firebaseError.localizedDescription)
                    return
                }
                else{
                    self.performSegue(withIdentifier: "LoggedInVC", sender: nil)

                }

            }
        }
    }
    
    
}
