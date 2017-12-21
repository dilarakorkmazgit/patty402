//
//  Home.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 16.11.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SDWebImage


class Home: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var burgerMenuView: UIView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    
    var showMenu = false
    
    var imageURL = [String]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let database = Database.database().reference()
    let storage = Storage.storage().reference()
    @IBOutlet weak var petImageOntoMap: UIImageView!
    let manager = CLLocationManager()
    var locations : NSMutableArray! = NSMutableArray()
    
    // KONUM SERVİSLERİ ETKİNLEŞTİRME
    /* let manager = CLLocationManager()
     
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     let location = locations [0]
     
     let span:MKCoordinateSpan = MKCoordinateSpanMake()
     let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
     
     let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation,span)
     map.setRegion(region, animated: true)
     
     self.map.showsUserLocation = true
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        burgerMenuView.layer.shadowOpacity = 1
        burgerMenuView.layer.shadowRadius = 6
        
        // KONUM SERVİSLERİ ETKİNLEŞTİRME
        /* manager.delegate = self
         manager.desiredAccuracy = kCLLocationAccuracyBest
         manager.requestWhenInUseAuthorization()
         manager.startUpdatingLocation()*/
        
        self.mapView.delegate = self
        mapView.showsUserLocation = true
        
        self.mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        database.child("locations").observe(.value, with: { snapshot in
            let value = snapshot.value as! NSDictionary
            let userId = value.allKeys[0] as! String
            self.database.child("locations").child(userId).observe(.value, with: { snapshot in
                let value = snapshot.value as! NSDictionary
                
                    let usersId = value["userId"] as! String
                    let latitude = value["latitude"] as! Double
                    let longitude = value["longitude"] as! Double
                    
                    self.database.child("user").child(userId).child("pet").observe(.value, with: { snapshot in
                        let userValue = snapshot.value as! NSDictionary
                        print(userValue)
                        print(usersId)
                        let locDict : NSMutableDictionary! = NSMutableDictionary()
                        
                        locDict.setValue(usersId, forKey: "userId")
                        locDict.setValue(latitude, forKey: "latitude")
                        locDict.setValue(longitude, forKey: "longitude")
                        locDict.setValue(userValue, forKey: "pet")
                        
                        //self.locations.add(locDict)
                        
                        DispatchQueue.main.async { [unowned self] in
                            //print(self.locations)
                            let dog = PPointAnnotation()
                            let dogCordinates = CLLocationCoordinate2DMake(latitude, longitude)
                            dog.coordinate = dogCordinates
                            dog.title = userValue.value(forKey: "petName") as? String ?? ""
                            dog.photoURL = userValue.value(forKey: "photo") as? String ?? ""
                            self.mapView.addAnnotation(dog)
                            
                        }
                    })
            })
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations [0]
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.020,0.020)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation,span)
        self.mapView.setRegion(region, animated: true)
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        self.mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if !(annotation is MKPointAnnotation) {
            print("Not registered")
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "petIdentifier")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "petIdentifier")
            annotationView!.canShowCallout = true
        }else {
            annotationView!.annotation = annotation
        }
       // let storageRef = Storage.storage().reference().child("ProfilImage/\(UUID().uuidString)") HATA????

        
        
      //  imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg")
        
//        let imageURL : NSURL? = NSURL(string:"https://firebasestorage.googleapis.com/v0/b/pattyapp-34c16.appspot.com/o/profileImage%2Fmango.png?alt=media&token=ba613ed4-51a0-4d32-8a31-136948606138")
//
//        if let URLimage = imageURL{
//
//
//            //annotationView?.image = UIImage(URLimage.sd_setImage(with: URLimage as URL))
//          petImageOntoMap.sd_setImage(with: URLimage as URL)
//
//
//
//
//        }
    
        let pannotation : PPointAnnotation = annotation as! PPointAnnotation
        let petImage : UIImageView = UIImageView()
        petImage.frame = CGRect(x: -16, y: -4, width: 32, height: 32)
        petImage.layer.cornerRadius = 16
        petImage.layer.masksToBounds = true
        petImage.clipsToBounds = true
        petImage.backgroundColor = UIColor.white
        petImage.sd_setImage(with: URL(string: pannotation.photoURL as! String), placeholderImage: UIImage(named: "placeholder.png"))

        annotationView?.addSubview(petImage)
        annotationView?.bringSubview(toFront: petImage)
        return annotationView
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func openBurgerMenu(_ sender: Any) {
        
        if(showMenu){
            
            leadingConst.constant = -140
            
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        
            
    }
    else{
            
            leadingConst.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        showMenu = !showMenu
    }
}
