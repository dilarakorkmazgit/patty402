//
//  HomeTest.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 2.01.2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation
import SDWebImage

class HomeTest: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var ref = Database.database().reference()
    var storageRef = Storage.storage().reference()
    let manager = CLLocationManager()
    var users = [User] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        fetchUser()
        
        }
    
    func fetchUser() {
        Database.database().reference().child("locations").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                
                let latitude = dictionary["latitude"] as! Float
                let longitude = dictionary["longitude"] as! Float
                user.photo = dictionary["photo"] as! String
                //user.username = dictionary["username"] as! String

               print(user.latitude, user.longitude, user.photo)
                
                self.users.append(user)
                let userValue = snapshot.value as! NSDictionary

                DispatchQueue.main.async { [unowned self] in
                    let dog = PPointAnnotation()
                    let dogCordinates = CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
                    dog.coordinate = dogCordinates
                    dog.title = userValue.value(forKey: "petName") as? String ?? ""
                    dog.photoURL = userValue.value(forKey: "photo") as? String ?? ""
                    self.mapView.addAnnotation(dog)
                    
                }
            }
            
        } , withCancel: nil)
        
        
    }
    @IBAction func logOutPressed(_ sender: Any) {
       
            
            do {
                try Auth.auth().signOut()
                print("çıkış yapıldı")
                
            } catch let logoutError {
                print(logoutError)
            }
            
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(loginVC, animated: true, completion: nil)
       
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
        
        let pannotation : PPointAnnotation = annotation as! PPointAnnotation
        let petImage : UIImageView = UIImageView()
        petImage.frame = CGRect(x: -16, y: -4, width: 50, height: 50)
        petImage.layer.cornerRadius = 16
        petImage.layer.masksToBounds = true
        petImage.clipsToBounds = true
        petImage.backgroundColor = UIColor.white
        petImage.sd_setImage(with: URL(string: pannotation.photoURL as String), placeholderImage: UIImage(named: "placeholder.png"))
        
        annotationView?.addSubview(petImage)
        annotationView?.bringSubview(toFront: petImage)
        return annotationView
        
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
