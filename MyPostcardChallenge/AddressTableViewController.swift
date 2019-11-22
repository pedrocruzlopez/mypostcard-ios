//
//  AddressTableViewController.swift
//  MyPostcardChallenge
//
//  Created by user on 11/22/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import UIKit

class AddressTableViewController: UITableViewController {

    
    var data: Data = Data()
    var addresses: [[String : Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                addresses = json["new_contacts"] as! [[String : Any]]
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addresses.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
        print(addresses[indexPath.row])
        
        /*
         
            address formats:

            CountryISO: DE
            recipientName
            addressLine1
            addressLine2
            zip city
            state
            country

            CountryISO: US
            recipientName
            addressLine1
            addressLine2
            city state zip
            country

            CountryISO: GB
            recipientName
            addressLine1
            addressLine2
            city
            state
            zip
            country
         
         */
        
        let address = addresses[indexPath.row] as [String:Any]
        print(address)
        
        let recipientName = address["recipientName"] as? String ?? ""
        let addressLine1 = address["addressLine1"] as? String ?? ""
        let addressLine2 = address["addressLine2"] as? String ?? ""
        let city = address["city"] as? String ?? ""
        let state = address["state"] as? String ?? ""
        let zip = address["zip"] as? String ?? ""
        let country = address["country"] as? String ?? ""
        
        let iso = address["countryiso"] as? String ?? ""
        if( iso == "DE"){
            
            cell.line1.text = recipientName
            cell.line2.text = addressLine1
            cell.line3.text = addressLine2
            cell.line4.text = zip + " " + city
            cell.line5.text = state
            cell.line6.text = country
            
        } else if (iso == "US") {
            
            cell.line1.text = recipientName
            cell.line2.text = addressLine1
            cell.line3.text = addressLine2
            cell.line4.text = city + " " + state + " " + zip
            cell.line5.text = country
            
            
        } else if (iso == "GB"){
            
            
            cell.line1.text = recipientName
            cell.line2.text = addressLine1
            cell.line3.text = addressLine2
            cell.line4.text = city
            cell.line5.text = zip
            cell.line6.text = state
            cell.line7.text = country
            
        }
        
       
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
