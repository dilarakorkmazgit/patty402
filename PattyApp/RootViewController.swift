//
//  RootViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 12/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let viewControllerCount = self.navigationController?.viewControllers.count;
        
        if(viewControllerCount != nil) {
            
            
            if(viewControllerCount! > 1 && !self.isKind(of: Home.self)) {
                let sendButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goBackTapped))
                
                self.navigationItem.leftBarButtonItem = sendButton

            } else {
                //let backImg: UIImage = UIImage(named: "back-1")!
                
                let sendButton = UIBarButtonItem(title: "Menü", style: UIBarButtonItemStyle.plain, target: self, action: #selector(menuTapped))
                sendButton.tintColor = UIColor.white
                //sendButton.setBackgroundImage(backImg, for: UIControlState.normal, barMetrics: .default)
                
                self.navigationItem.leftBarButtonItem = sendButton
            }
        } else {
            //do nothing
        }
    }
    
    public func goBackTapped(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func menuTapped(sender: AnyObject) {
        print("menu tapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
