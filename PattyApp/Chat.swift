//
//  Chat.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 31.12.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase

class Chat: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Çıkış", style: .plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "write")

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(newMessage))
        
        checkIfUserIsLoggedIn()
    }
    func newMessage() {
        
        let chatInfo = ChatInfo()
        let navController = UINavigationController(rootViewController: chatInfo)
        present(navController, animated: true, completion: nil)
        
    }
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("user").child(uid!).child("personalInfo").observe(.value, with: {(snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    self.navigationItem.title = dictionary["firstname"] as? String
                }
                
                print(snapshot)
            } , withCancel: nil)
        }
    }
    
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
            print("çıkış yapıldı")

        } catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(loginVC, animated: true, completion: nil)
    }
}
