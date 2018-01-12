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


class Home: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate ,UIViewControllerTransitioningDelegate{
    
      let customPresentationController = CustomViewPresentationController(direction: .top)
    
    
    @IBAction func TappedswitchButton(_ sender: Any) {
        
       
    }
    
    @IBOutlet weak var switchtoGeneralHome: UIButton!
    
    @IBOutlet weak var burgerMenuView: UIView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var bildirimler: UIButton!
    @IBOutlet weak var iletişim: UIButton!
    @IBOutlet weak var cikis: UIButton!
    @IBOutlet weak var merhaba: UILabel!
    
    var showMenu = false
    var imageURL = [String]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var petImageOntoMap: UIImageView!
    
    var ref = Database.database().reference()
    var storageRef = Storage.storage().reference()
    let manager = CLLocationManager()
    var users = [User] ()
    
    let userid = Auth.auth().currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.width / 2
        ProfileImage.clipsToBounds = true
        ProfileImage.layer.borderColor = UIColor.white.cgColor
        profileImage()

        burgerMenuView.layer.shadowOpacity = 1
        burgerMenuView.layer.shadowRadius = 6
       
        self.mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        fetchUser()
        let size = CGSize(width: 5, height: 5)
        
        profile.layer.shadowOffset = size
        profile.layer.shadowRadius = 5
        profile.layer.shadowColor = UIColor.black.cgColor
        profile.layer.shadowOpacity = 0.5
        
        
        bildirimler.layer.shadowOffset = size
        bildirimler.layer.shadowRadius = 5
        bildirimler.layer.shadowColor = UIColor.black.cgColor
        bildirimler.layer.shadowOpacity = 0.5
        
        
        iletişim.layer.shadowOffset = size
        iletişim.layer.shadowRadius = 5
        iletişim.layer.shadowColor = UIColor.black.cgColor
        iletişim.layer.shadowOpacity = 0.5
        
        
        cikis.layer.shadowOffset = size
        cikis.layer.shadowRadius = 5
        cikis.layer.shadowColor = UIColor.black.cgColor
        cikis.layer.shadowOpacity = 0.5
        
        
        ProfileImage.layer.shadowOffset = size
        ProfileImage.layer.shadowRadius = 5
        ProfileImage.layer.shadowColor = UIColor.black.cgColor
        ProfileImage.layer.shadowOpacity = 0.5
        
        nameLabel.layer.shadowOffset = size
        nameLabel.layer.shadowRadius = 5
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowOpacity = 0.5
       
        mailLabel.layer.shadowOffset = size
        mailLabel.layer.shadowRadius = 5
        mailLabel.layer.shadowColor = UIColor.black.cgColor
        mailLabel.layer.shadowOpacity = 0.5
        
        merhaba.layer.shadowOffset = size
        merhaba.layer.shadowRadius = 5
        merhaba.layer.shadowColor = UIColor.black.cgColor
        merhaba.layer.shadowOpacity = 0.5
        
      
    }
    func fetchUser() {
        Database.database().reference().child("locations").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                
                let latitude = dictionary["latitude"] as! Float
                let longitude = dictionary["longitude"] as! Float
                user.photo = dictionary["photo"] as! String
                
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
    
    
    

    @IBAction func signOutPress(_ sender: Any) {
        
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
    func profileImage () {
        
        
        ref.child("user").child(userid!).child("personalInfo").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let firstname = value?["firstname"] as? String ?? ""
            let lastname = value?["lastname"] as? String ?? ""
            let mail = value?["email"] as? String ?? ""

            self.nameLabel.text = "\(firstname.description) \(lastname.description)"
            self.mailLabel.text = mail.description
            self.nameLabel.adjustsFontSizeToFitWidth = true
            self.mailLabel.adjustsFontSizeToFitWidth = true
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("user").child(userid!).child("pet").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let profileImageURL = value?["photo"] as? String ?? ""
            
            self.ProfileImage.sd_setImage(with: URL(string: profileImageURL ), placeholderImage: UIImage(named: "placeholder.png"))
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BACKGROUND-1")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAction" {
            
            let toVC = segue.destination as UIViewController
            toVC.transitioningDelegate = self
            
        }
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentationController
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
