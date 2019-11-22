//
//  TableViewController.swift
//  MyPostcardChallenge
//
//  Created by user on 11/21/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import UIKit

struct Avatar {
    var name: String
    var imageURL: String
    var imageData: UIImage?
}

class TableViewController: UITableViewController, XMLParserDelegate {
    
    
    var avatars: [Avatar] = []
    var elementName: String = String()
    var name = String()
    var imageURL = String()
    var networkService = NetworkingService()
    
    var data: Data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        
        self.isModalInPresentation = true;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return avatars.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        var avatar = avatars[indexPath.row]
        cell.avatarTitle.text = avatar.name
        cell.avatarImage.image = nil
        cell.avatarUsed.text = "\(cell.reuse)"
        if(cell.reuse == 0){
            
            cell.reuse = 1
            
        } else {
            cell.reuse += 1
        }
        
        
        if(avatar.imageData == nil){
            DispatchQueue.global(qos: .background).async {
                let url = URL(string: avatar.imageURL)!
                self.networkService.getImage(from: url) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Error occured")
                        return
                    }
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        avatar.imageData = image!
                        self.avatars[indexPath.row] = avatar
                        cell.avatarImage.image = image
                    }
                }
            }
        } else {
            cell.avatarImage.image = avatar.imageData
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let avatar = avatars[indexPath.row]
        print(avatar.name)
        if(indexPath.row == 2){
            let alert = UIAlertController(title: avatar.name, message: avatar.name, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             self.present(alert, animated: true)
        } else {
            
            let vc = self.storyboard?.instantiateViewController(identifier: "modalView") as! ModalViewController
            vc.modalPresentationStyle = .overCurrentContext
            vc.avatarTitle = avatar.name
            self.present(vc, animated: true) {
                
            }
            
        }
        
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
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "avatar" {
            name = String()
            imageURL = String()
        }

        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "avatar" {
            let avatar = Avatar(name: name, imageURL: imageURL, imageData: nil)
            avatars.append(avatar)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "name" {
                name += data
            } else if self.elementName == "imageurl" {
                imageURL += data
            }
        }
    }

}
