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


class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var colorRange :[UIColor] = [UIColor.red,UIColor.yellow,UIColor.blue,UIColor.purple]
    
    var frame = CGRect(x:0,y:0,width:0,height:0)
    
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    //Düzenleeee
    var frameVideo = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Do any additional setup after loading the view, typically from a nib.
        
        //Adding different scrolview Page
        
        pageControl.numberOfPages = colorRange.count
        for index in 0..<colorRange.count {
            
            frame.origin.x = ScrollView.frame.size.width * CGFloat(index)
            frame.size = ScrollView.frame.size
            
            let view = UIView(frame:frame)
            view.backgroundColor = colorRange[index]
            self.ScrollView.addSubview(view)
        }
        
        ScrollView.contentSize = CGSize(width:(ScrollView.frame.size.width * CGFloat(colorRange.count)),height :ScrollView.frame.size.height)
        
        ScrollView.delegate = self
        
        
        let URL:NSURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
        
        Player = AVPlayer.init(url: URL as URL)
        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravityResize
        PlayerLayer.frame.size = frameVideo.size
        Player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        Player.isMuted = true
        Player.play()
        
        view.layer.insertSublayer(PlayerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Player.currentItem)
        
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        let pageNumber = ScrollView.contentOffset.x / ScrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        pageControl.currentPageIndicatorTintColor = colorRange[pageControl.currentPage]
        
    }
    
    func playerItemReachEnd(notification: NSNotification) {
        
        Player.seek(to: kCMTimeZero)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pageChanger(_ sender: UIPageControl) {
        
        let x = CGFloat(sender.currentPage) * ScrollView.frame.size.width
        ScrollView.contentOffset = CGPoint(x:x,y:0)
    }
    
}

