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

class LoggedInVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    var loggedInUser:AnyObject?
    var ref = Database.database().reference()
    var storageRef = Storage.storage().reference()

    @IBOutlet weak var petNameLabel: UITextField!
    
    //butonlar
    @IBOutlet weak var cinsiyetButton: UIButton!
    
    @IBOutlet weak var türButton: UIButton!
    
    @IBOutlet weak var ageButton: UIButton!
    
    @IBOutlet weak var colorBotton: UIButton!
    
    @IBOutlet weak var healthButton: UIButton!
    
    //pickerlar
    @IBOutlet weak var cinsiyetPicker: UIPickerView!
    @IBOutlet weak var turPicher: UIPickerView!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var healthPicker: UIPickerView!
    
    //pet resmi
    @IBOutlet weak var imageView: UIImageView!
    
    
     let cinsiyet = ["Erkek","Dişi"]
    let tur = ["pug","terrier","dogo","doberman"]
     let color = ["siyah","beyaz","kahverangi","karışık"]
    let age = ["1","2","3","4","5"]
    let health = ["kısır","Kısır Değil"]


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        

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
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
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
    
    
    
    @IBAction func kaydetPressed(_ sender: Any) {
    
      
        
     let userid = Auth.auth().currentUser?.uid
        
        let petName :String = self.petNameLabel.text!
         let gender :String = self.cinsiyetButton.currentTitle!
        let age :String = self.ageButton.currentTitle!
        let tur :String = self.türButton.currentTitle!
        let health:String = self.healthButton.currentTitle!
        let color :String = self.colorBotton.currentTitle!
        //let petImagegy :UIImage = self.imageView.image!
        
       
        
        
        //create pet tuple into user
        self.ref.child("user").child(userid!).child("pet").setValue(["petname": petName, "gender": gender, "age": age, "tür":tur, "color": color,"health": health])

        
      
        
        
        
    updateUserProfile()
     
    }
        func updateUserProfile(){
        
        if let userid = Auth.auth().currentUser?.uid{
            
            let item = storageRef.child("profileImage").child(userid)
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
                            self.ref.child("profile").child(userid).updateChildValues(newValuesforProfile,withCompletionBlock:{(error,ref) in
                                
                                if error != nil{
                                    print(error!)
                                    return
                                }
                                print("succesfull updated profile")
                            })
                        }
                    })
                    
                })
    }
      
}
        
        } }
