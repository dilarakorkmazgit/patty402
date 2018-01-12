//
//  WelcomeViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 11/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
  
    @IBAction func showProfileView(_ sender: Any) {
        
        performSegue(withIdentifier: "showprofileview", sender: sender)
    
    }
    
    @IBAction func showMapBack(_ sender: Any) {
        
         performSegue(withIdentifier: "showMapback", sender: sender)
    }
    
    @IBAction func goToChat(_ sender: Any) {
       
        
         performSegue(withIdentifier: "goToChatView", sender: sender)
    }
    
    
    
    @IBAction func goToFilteringTableView(_ sender: Any) {
        
          performSegue(withIdentifier: "filteringTableView", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //fit the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
