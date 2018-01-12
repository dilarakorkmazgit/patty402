//
//  WelcomeViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 11/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//
import UIKit

class WelcomeViewController: UIViewController {
  
    public var prVC = Home()
    
    @IBAction func showProfileView(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"profileView") as! RootViewController
        
        self.dismiss(animated: true) {
            self.prVC.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func showMapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToChat(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"chatView") as! RootViewController
        
        self.dismiss(animated: true) {
            self.prVC.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    @IBAction func goToFilteringTableView(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"filterView") as! RootViewController
        
        self.dismiss(animated: true) {
            self.prVC.navigationController?.pushViewController(viewController, animated: true)
        }
        
          //performSegue(withIdentifier: "filteringTableView", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //fit the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        // Do any additional setup after loading the view.
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
