//
//  ViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 16/10/2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//
import UIKit
//import AVFoundation
//import MapKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var login: UIButton!
    
    var logoImage: [UIImage] = [
        UIImage(named: "hosgeldiniz.png")!,
        UIImage(named: "bildirimler.png")!,
        UIImage(named: "kesfet.png")!,
        UIImage(named: "kesfet.png")!
    ]

    var colorRange :[UIColor] = [UIColor.clear,UIColor.clear,UIColor.clear,UIColor.clear]
    
    var frame = CGRect(x:0,y:0,width:0,height:0)
    
    //var Player: AVPlayer!
    //var PlayerLayer: AVPlayerLayer!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let size = CGSize(width: 5, height: 5)
        create.layer.shadowOffset = size
        create.layer.shadowRadius = 5
        create.layer.shadowColor = UIColor.black.cgColor
        create.layer.shadowOpacity = 0.5
        login.layer.shadowOffset = size
        login.layer.shadowRadius = 5
        login.layer.shadowColor = UIColor.black.cgColor
        login.layer.shadowOpacity = 0.5

        
        
        //fit the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BACKGROUND-1")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        //Adding different scrollview Page
        
        for index in 0..<4 {
            
            frame.origin.x = self.ScrollView.frame.size.width * CGFloat(index)
            frame.size = self.ScrollView.frame.size
            self.ScrollView.isPagingEnabled = true
            let subview = UIImageView(frame: frame)
            subview.image = logoImage[index]
            print("geldim1")
            self.ScrollView.addSubview(subview)
            print("geldim2")

        }

        
        ScrollView.contentSize = CGSize(width:(ScrollView.frame.size.width * CGFloat(logoImage.count)),height :ScrollView.frame.size.height)
        ScrollView.delegate = self
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        let pageNumber = ScrollView.contentOffset.x / ScrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        pageControl.currentPageIndicatorTintColor = colorRange[pageControl.currentPage]
        
    }
    
    /*func playerItemReachEnd(notification: NSNotification) {
        
        Player.seek(to: kCMTimeZero)
        
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pageChanger(_ sender: UIPageControl) {
        
        let x = CGFloat(sender.currentPage) * ScrollView.frame.size.width
        ScrollView.contentOffset = CGPoint(x:x,y:0)
    }
    
}
