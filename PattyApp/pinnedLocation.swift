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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.loggedInUser = Auth.auth().currentUser
        
        self.mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let dialog = UIAlertController(title: "Pet Konumu", message: "Petinizin konumunu haritada uzun basarak belirleyebilirsiniz", preferredStyle: UIAlertControllerStyle.alert)
        dialog.addAction(UIAlertAction(title: "TAMAM", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async(execute: {
            self.present(dialog, animated: true, completion: nil)
        })

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
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
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "pin")
        }
        
        return annotationView
    }
    func dismissKeyboard() {
        view.endEditing(true)
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
        
        self.ref.child("user").child(userid!).child("pet").updateChildValues(["latitude": annotation.coordinate.latitude, "longitude": annotation.coordinate.longitude])
        
    }
    
    
}
