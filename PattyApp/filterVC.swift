//
//  filterVC.swift
//  PattyApp
//
//  Created by Burak Nurcicek on 11.04.2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit

class filterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView_1: UITableView!
    @IBOutlet weak var tableView_2: UITableView!
    @IBOutlet weak var tableView_3: UITableView!
    
    let cinsiyet =  ["Dişi","Erkek"]
    var count = 2
    var count2 = 3
    var count3 = 4
    
    
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
            var cell: cinsiyetTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView1") as! cinsiyetTableView
            return cell
        }
        else if(tableView == self.tableView_2) {
            var cell: turTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView2") as! turTableView
            cell.labelText2.text = "b \(indexPath.row) "
            return cell
        }
        else {
            var cell: yasTableView = tableView.dequeueReusableCell(withIdentifier: "cellTableView3") as! yasTableView
            cell.labelText3.text = "c \(indexPath.row) "
            return cell
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (tableView == self.tableView_1) {
            return count
        }else if(tableView == self.tableView_2) {
            return count2
            
        }else if(tableView == self.tableView_3){
            return count3
        }
        return count
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

