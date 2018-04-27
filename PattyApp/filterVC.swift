//
//  filterVC.swift
//  PattyApp
//
//  Created by Burak Nurcicek on 11.04.2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase

class filterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView_1: UITableView!
    @IBOutlet weak var tableView_2: UITableView!
    @IBOutlet weak var tableView_3: UITableView!
    
    let cinsiyet =  ["Dişi","Erkek"]
    let tur = ["Pug","Terrier","Dogo","Doberman","Rottwailer","Beagle","Buldog","Danua","Kaniş","Chihuahua","Boxor","Cow-cow","Pitbull","Akita","Pomeranian","Bulmastif"]
    let age = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    
    
    var pet = [Pet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView_1.delegate = self
        self.tableView_1.dataSource = self
        
        self.tableView_2.delegate = self
        self.tableView_2.dataSource = self
        
        self.tableView_3.delegate = self
        self.tableView_3.dataSource = self
        observeGender()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     
        if (tableView == self.tableView_1) {
            var cell: cinsiyetTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView1") as! cinsiyetTableView

            cell.labelText1.text = cinsiyet[indexPath.row]
            return cell
        }
        else if(tableView == self.tableView_2) {
            var cell: turTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView2") as! turTableView
            cell.labelText2.text =  tur[indexPath.row]
            return cell
        }
        else {
            var cell: yasTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView3") as! yasTableView
            cell.labelText3.text =  age[indexPath.row]
            return cell
            
        }
        
    }
    func observeGender(){
        
        Database.database().reference().child("user").child("pet").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let pet = Pet()
                
                pet.gender = dictionary["gender"] as? String
              
                
                self.pet.append(pet)
                
                DispatchQueue.main.async(execute: {
                    self.tableView_1.reloadData()
                })
            }
            
        } , withCancel: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (tableView == self.tableView_1) {
            return cinsiyet.count
        }else if(tableView == self.tableView_2) {
            return tur.count
            
        }else if(tableView == self.tableView_3){
            return age.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == self.tableView_1) {
            if(tableView_1.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none) {
                tableView_1.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark

            }
            else{
                tableView_1.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none

            }
        
        }
       else if(tableView == self.tableView_2) {
            if(tableView_2.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none) {
                tableView_2.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                
            }
            else{
                tableView_2.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                
            }
            
        }
        else if(tableView == self.tableView_3) {
            if(tableView_3.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none) {
                tableView_3.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                
            }
            else{
                tableView_3.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                
            }
            
        }
       
        
        
    }
}

