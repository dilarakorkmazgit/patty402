//
//  pinnedLocation.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 8.12.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class pinnedLocation: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var loggedInUser:AnyObject?
    var ref = Database.database().reference()
    var storageRef = Storage.storage().reference()
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loggedInUser = Auth.auth().currentUser
        
        self.mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations [0]
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.20,0.20)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation,span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
        
        let userid = Auth.auth().currentUser?.uid
            
            let location = sender.location(in: self.mapView)
            let locCord = self.mapView.convert(location, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = locCord
             annotation.title = "Pet Konumu"
            
            
            
            self.mapView.removeAnnotations(mapView.annotations)
            self.mapView.addAnnotation(annotation)
            print("\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
            
            self.ref.child(userid!).child("pet").setValue(["location": annotation.coordinate.latitude, "longitude": annotation.coordinate.longitude])

        
    }
}
