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
    
    var checkedItemsForGender = [String]()
    var checkedItemsForAge = [String]()
    var checkedItemsForTur = [String]()
    
    var arr_selectedIndexPath1 = NSMutableArray()
    var arr_selectedIndexPath2 = NSMutableArray()
    var arr_selectedIndexPath3 = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView_1.delegate = self
        self.tableView_1.dataSource = self
        
        self.tableView_2.delegate = self
        self.tableView_2.dataSource = self
        
        self.tableView_3.delegate = self
        self.tableView_3.dataSource = self
      
                
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (tableView == self.tableView_1) {
            var cell1: cinsiyetTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView1") as! cinsiyetTableView
            cell1.labelText1.text = cinsiyet[indexPath.row]

            if (arr_selectedIndexPath1.contains(indexPath)) {
                cell1.accessoryType = .checkmark
            }
            else {
                cell1.accessoryType = .none
               


                
            }

            return cell1
        }
        else if(tableView == self.tableView_2) {
            var cell2: turTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView2") as! turTableView
            cell2.labelText2.text =  tur[indexPath.row]
 
            
            if (arr_selectedIndexPath2.contains(indexPath)) {
                cell2.accessoryType = .checkmark

            }
            else{
                cell2.accessoryType = .none
                
            }
            

            return cell2
        }
        else if(tableView == self.tableView_3) {
            var cell3: yasTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView3") as! yasTableView
            cell3.labelText3.text =  age[indexPath.row]

            if (arr_selectedIndexPath3.contains(indexPath)) {
                cell3.accessoryType = .checkmark

            }
            else {
                cell3.accessoryType = .none
               
                
            }
            
            return cell3
            
        }
        else {
            var cell4: cinsiyetTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView1") as! cinsiyetTableView
            return cell4
        }
        
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
    
    @IBAction func filteringButton(_ sender: Any) {
        
        print(checkedItemsForAge)
        print(checkedItemsForGender)
        print(checkedItemsForTur)
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == self.tableView_1) {
            if arr_selectedIndexPath1.contains(indexPath) {
                arr_selectedIndexPath1.remove(indexPath)
                if let index = checkedItemsForGender.index(of: cinsiyet[indexPath.row]) {
                    checkedItemsForGender.remove(at: index);
                    
                }

                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            }
            else {
                arr_selectedIndexPath1.add(indexPath)
                checkedItemsForGender.append(cinsiyet[indexPath.row])

                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            }

            
        }
        else if(tableView == self.tableView_2) {
            if arr_selectedIndexPath2.contains(indexPath) {
                arr_selectedIndexPath2.remove(indexPath)
                if let index = checkedItemsForTur.index(of: tur[indexPath.row]) {
                    checkedItemsForTur.remove(at: index);
                    
                }
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            }
            else {
                arr_selectedIndexPath2.add(indexPath)
                checkedItemsForTur.append(tur[indexPath.row])
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            
            
        }
        else if(tableView == self.tableView_3) {
            if arr_selectedIndexPath3.contains(indexPath) {
                arr_selectedIndexPath3.remove(indexPath)
                if let index = checkedItemsForAge.index(of: age[indexPath.row]) {
                    checkedItemsForAge.remove(at: index);
                    
                }
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            }
            else {
                arr_selectedIndexPath3.add(indexPath)
                checkedItemsForAge.append(age[indexPath.row])
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            
            
        }

    }
    
}

