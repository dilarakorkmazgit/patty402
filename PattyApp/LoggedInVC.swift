//
//  LoggedInVC.swift
//  PattyApp
//
//  Created by Burak Nurçiçek on 18.10.2017.
//  Copyright © 2017 Dilara Korkmaz. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class LoggedInVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var loggedInUser:AnyObject?
    var ref = Database.database().reference()
    var storageRef = Storage.storage().reference()
    
    @IBOutlet weak var petProfileImage: UIImageView!
    
    @IBOutlet weak var petNameLabel: UITextField!
    @IBOutlet weak var kaydetPressed: UIButton!
    @IBOutlet weak var noPet: UIButton!
    @IBOutlet weak var devam: UIButton!
    @IBOutlet weak var konum: UILabel!
    
    //butonlar
    @IBOutlet weak var cinsiyetButton: UIButton!
    @IBOutlet weak var türButton: UIButton!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var colorBotton: UIButton!
    @IBOutlet weak var healthButton: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    //pickerlar
    @IBOutlet weak var cinsiyetPicker: UIPickerView!
    @IBOutlet weak var turPicher: UIPickerView!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var healthPicker: UIPickerView!
    
    //pet resmi
    @IBOutlet weak var imageView: UIImageView!
    
    let cinsiyet = ["Erkek","Dişi"]
    let tur = ["Pug","Terrier","Dogo","Doberman","Rottwailer","Beagle","Buldog","Danua","Kaniş","Chihuahua","Boxor","Cow-cow","Pitbull","Akita","Pomeranian","Bulmastif"]
    let color = ["Siyah","Beyaz","Kahverangi","Karışık"]
    let age = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    let health = ["Kısır","Kısır Değil"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        petProfileImage.layer.cornerRadius = petProfileImage.frame.size.width / 2
        petProfileImage.clipsToBounds = true
        petProfileImage.layer.borderColor = UIColor.white.cgColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-profil")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.loggedInUser = Auth.auth().currentUser
        
        cinsiyetPicker.dataSource = self
        cinsiyetPicker.delegate = self
        
        turPicher.dataSource = self
        turPicher.delegate = self
        
        agePicker.dataSource = self
        agePicker.delegate = self
        
        colorPicker.dataSource = self
        colorPicker.delegate = self
        
        healthPicker.dataSource = self
        healthPicker.delegate = self
        
        let size = CGSize(width: 5, height: 5)
        
        kaydetPressed.layer.shadowOffset = size
        kaydetPressed.layer.shadowRadius = 5
        kaydetPressed.layer.shadowColor = UIColor.black.cgColor
        kaydetPressed.layer.shadowOpacity = 0.5
        noPet.layer.shadowOffset = size
        noPet.layer.shadowRadius = 5
        noPet.layer.shadowColor = UIColor.black.cgColor
        noPet.layer.shadowOpacity = 0.5
        devam.layer.shadowOffset = size
        devam.layer.shadowRadius = 5
        devam.layer.shadowColor = UIColor.black.cgColor
        devam.layer.shadowOpacity = 0.5
        cinsiyetButton.layer.shadowOffset = size
        cinsiyetButton.layer.shadowRadius = 5
        cinsiyetButton.layer.shadowColor = UIColor.black.cgColor
        cinsiyetButton.layer.shadowOpacity = 0.5
        türButton.layer.shadowOffset = size
        türButton.layer.shadowRadius = 5
        türButton.layer.shadowColor = UIColor.black.cgColor
        türButton.layer.shadowOpacity = 0.5
        ageButton.layer.shadowOffset = size
        ageButton.layer.shadowRadius = 5
        ageButton.layer.shadowColor = UIColor.black.cgColor
        ageButton.layer.shadowOpacity = 0.5
        colorBotton.layer.shadowOffset = size
        colorBotton.layer.shadowRadius = 5
        colorBotton.layer.shadowColor = UIColor.black.cgColor
        colorBotton.layer.shadowOpacity = 0.5
        healthButton.layer.shadowOffset = size
        healthButton.layer.shadowRadius = 5
        healthButton.layer.shadowColor = UIColor.black.cgColor
        healthButton.layer.shadowOpacity = 0.5
        konum.layer.shadowOffset = size
        konum.layer.shadowRadius = 5
        konum.layer.shadowColor = UIColor.black.cgColor
        konum.layer.shadowOpacity = 0.5
        plus.layer.shadowOffset = size
        plus.layer.shadowRadius = 5
        plus.layer.shadowColor = UIColor.black.cgColor
        plus.layer.shadowOpacity = 0.5
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //when pressed the button,show picker
    @IBAction func cinsiyetPressed(_ sender: Any) {
        cinsiyetPicker.isHidden = false
        
    }
    
    @IBAction func turPressed(_ sender: Any) {
        turPicher.isHidden = false
        
    }
    
    @IBAction func agePressed(_ sender: Any) {
        
        agePicker.isHidden = false
        
    }
    
    @IBAction func colorPressed(_ sender: Any) {
        
        colorPicker.isHidden = false
        
    }
    
    @IBAction func popToRoot(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func healthPressed(_ sender: Any) {
        healthPicker.isHidden = false
        
    }
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Bir Profil Fotoğrafı Seçin", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Kamera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else {
                print ("Kamera aktif değil")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Fotoğraf Albümünden Seç", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image_Camera = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image_Camera
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag==1{
            return cinsiyet.count
            
        }
        else if pickerView.tag==2{
            return tur.count
        }
        else if pickerView.tag==3{
            return age.count
        }
        else if pickerView.tag==4{
            return color.count
        }
        else if pickerView.tag==5 {
            return health.count
        }
        return health.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag==1{
            return cinsiyet[row]
            
        }
        else if pickerView.tag==2{
            return tur[row]
        }
        else if pickerView.tag==3{
            return age[row]
        }
        else if pickerView.tag==4{
            return color[row]
        }
        else if pickerView.tag==5 {
            return health[row]
        }
        return health[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag==1{
            cinsiyetButton.setTitle(cinsiyet[row], for: UIControlState())
            cinsiyetPicker.isHidden = true
        }
        if pickerView.tag==2{
            türButton.setTitle(tur[row], for: UIControlState())
            turPicher.isHidden = true
        }
        if pickerView.tag==3{
            ageButton.setTitle(age[row], for: UIControlState())
            agePicker.isHidden = true
        }
        if pickerView.tag==4{
            colorBotton.setTitle(color[row], for: UIControlState())
            colorPicker.isHidden = true
        }
        if pickerView.tag==5{
            healthButton.setTitle(health[row], for: UIControlState())
            healthPicker.isHidden = true
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //saving data to firebase about pet info
    @IBAction func kaydetPressed(_ sender: Any) {
        
        if let userid = Auth.auth().currentUser?.uid{
            
            let item = storageRef.child("profileImage").child("\(userid).png")
            guard let image = imageView.image
                else {
                    return
            }
            if let newimage = UIImagePNGRepresentation(image){
                item.putData(newimage, metadata: nil , completion:{(metadata, error ) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    item.downloadURL(completion: {(url,error)in
                        if error != nil{
                            print(error!)
                            return
                        }
                        if let profilePhotoURL = url?.absoluteString {
                            guard let petName = self.petNameLabel.text else {return}
                            guard let gender = self.cinsiyetButton.currentTitle else {return}
                            guard let age = self.ageButton.currentTitle else {return}
                            guard let tur = self.türButton.currentTitle else {return}
                            guard let health = self.healthButton.currentTitle else {return}
                            guard let color = self.colorBotton.currentTitle else {return}
                            let newValuesforProfile=["photo": profilePhotoURL,
                                                     "petName":petName ,
                                                     "gender": gender,
                                                     "age" : age,
                                                     "tur": tur,
                                                     "health": health,
                                                     "color" :color]
                            
                            self.ref.child("user").child(userid).child("pet").setValue(newValuesforProfile,withCompletionBlock:{(error,ref) in
                                if error != nil{
                                    print(error!)
                                    return
                                }
                                print("saving pet info to firebase successfully")
                            })
                            self.ref.child("locations").child(userid).updateChildValues(newValuesforProfile,withCompletionBlock:{(error,ref) in
                                if error != nil{
                                    print(error!)
                                    return
                                }
                                print("loca gitti")
                            })
                            
                        }
                    })
                })
            }
        }
        let dialog = UIAlertController(title: "Pet Bilgileri", message: "Pet bilgileriniz kaydedildi. Yakınınızdaki diğer petleri görmek için devam butonuna basınız", preferredStyle: UIAlertControllerStyle.alert)
        dialog.addAction(UIAlertAction(title: "TAMAM", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async(execute: {
            self.present(dialog, animated: true, completion: nil)
        })
    }
   

}
