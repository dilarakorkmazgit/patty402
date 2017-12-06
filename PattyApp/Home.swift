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

class Home: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var dog = MKPointAnnotation()
    let database = Database.database().reference()
    let storage = Storage.storage().reference()
    
    
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
        
 
        
        // KONUM SERVİSLERİ ETKİNLEŞTİRME
        /* manager.delegate = self
         manager.desiredAccuracy = kCLLocationAccuracyBest
         manager.requestWhenInUseAuthorization()
         manager.startUpdatingLocation()*/
        
        self.mapView.delegate = self
        mapView.showsUserLocation = true
        
        let dogCordinates = CLLocationCoordinate2DMake(41.005, 39.72694)
        dog.coordinate = dogCordinates
        dog.title = "dog test"
        mapView.addAnnotation(dog)
        
        print("dog set to \(String(describing: dog.coordinate))")
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

        let mango = storage.child("profileImage/mango.png")
        
        mango.getData(maxSize: 1*1000*2000) { (data, error) in
            annotationView!.image = UIImage(data: data!)
           
        }
        return annotationView
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
