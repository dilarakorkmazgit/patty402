//
//  resetPasswordVC.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 19.10.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class resetPasswordVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BACKGROUND.login")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func resetPressed(_ sender: Any) {
        
        if let email = emailField.text {
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
               
                    let dialog = UIAlertController(title: "E-posta Gönderildi", message: "\(email) hesabına yeniden girebilmeni sağlayacak bir bağlantı içeren e-posta gönderdik", preferredStyle: UIAlertControllerStyle.alert)
                    dialog.addAction(UIAlertAction(title: "TAMAM", style: UIAlertActionStyle.default, handler: nil))
                    DispatchQueue.main.async(execute: {
                        self.present(dialog, animated: true, completion: nil)
                    })
                

            }
            
            
        }
        
        
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }

}
