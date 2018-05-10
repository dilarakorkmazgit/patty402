//
//  BakiciViewCon.swift
//  PattyApp
//
//  Created by Burak Nurcicek on 10.05.2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit

class BakiciViewCon: UIViewController, BEMCheckBoxDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    @IBOutlet weak var profile: UIImageView!
    
    @IBAction func picturePressed(_ sender: Any) {
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
        
        profile.image = image_Camera
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var box: BEMCheckBox!
    @IBOutlet weak var box8: BEMCheckBox!
    @IBOutlet weak var box7: BEMCheckBox!
    @IBOutlet weak var box6: BEMCheckBox!
    @IBOutlet weak var box5: BEMCheckBox!
    @IBOutlet weak var box4: BEMCheckBox!
    @IBOutlet weak var box3: BEMCheckBox!
    @IBOutlet weak var box2: BEMCheckBox!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        box.delegate = self
        box2.delegate = self
        box3.delegate = self
        box4.delegate = self
        box5.delegate = self
        box6.delegate = self
        box7.delegate = self
        box8.delegate = self
        
        profile.layer.cornerRadius = profile.frame.size.width / 2
        profile.clipsToBounds = true
        profile.layer.borderColor = UIColor.white.cgColor        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        print("user tap \(checkBox.tag): \(checkBox.on)")
        
        
    }
    @IBAction func basvurPressed(_ sender: Any) {
        let dialog = UIAlertController(title: "Bakıcılık Başvurusu", message: "Bakıcılık başvurunuz değerlendirmeye alınmıştır.", preferredStyle: UIAlertControllerStyle.alert)
        dialog.addAction(UIAlertAction(title: "TAMAM", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async(execute: {
            self.present(dialog, animated: true, completion: nil)
        })
    }
    
}
