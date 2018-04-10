//
//  BakiciViewController.swift
//  PattyApp
//
//  Created by Burak Nurcicek on 10.04.2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit

class BakiciViewController: RootViewController, UITableViewDataSource, UITableViewDelegate
{

    let kediBakıcı = ["Günlük", "Yatılı", "Uzun Süreli"]
    let kopekBakıcı = ["Günlük", "Yatılı", "Uzun Süreli","Gezdirme","Küçük Tür", "Büyük Tür"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kediBakıcı.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = kediBakıcı[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none
        }
    }
    
    
}
