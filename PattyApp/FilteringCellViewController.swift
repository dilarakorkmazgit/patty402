//
//  FilteringCellViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 16/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase



class FilteringCellViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //fit the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-profil")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
