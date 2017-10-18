//
//  ViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 16/10/2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit


class ViewController: UIViewController {
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        
        
        let URL:NSURL = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/pattyapp-34c16.appspot.com/o/dog1.mp4?alt=media&token=98ab3c41-c645-4535-a70b-41511b5df602")!
        Player = AVPlayer.init(url: URL as URL)
        

        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        PlayerLayer.frame = view.layer.frame
        
        Player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        view.sizeToFit()
        Player.isMuted = true

        Player.play()
        
        view.layer.insertSublayer(PlayerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Player.currentItem)
    }
    func playerItemReachEnd(notification: NSNotification) {
        
        Player.seek(to: kCMTimeZero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

