//
//  FilterTableViewController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 12/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FilterTableViewController: UITableViewController {
    
    func observeAllUser(){
        
        Database.database().reference().child("user").observe(.childAdded, with: {(snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                
              //  let userInfo = User()
                let petInfo = Pet()
                

                // get pet info
                petInfo.petname = dictionary["petName"] as? String
                petInfo.gendery = dictionary["gender"] as? String
                petInfo.tur = dictionary["tur"] as? String
                petInfo.age = dictionary["age"] as? Int
                petInfo.color = dictionary["color"] as? String
                petInfo.health = dictionary["health"] as? String
                petInfo.photo = dictionary["photo"] as? URL

                
                print(snapshot.value!)
                print("oldu mu olmadı mı anlamıyommmmm")
                print("olmuşş:)))")
                
                
                
                
              
            }
            
        }, withCancel: nil)
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeAllUser()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
