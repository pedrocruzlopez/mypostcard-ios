//
//  SecondViewController.swift
//  MyPostcardChallenge
//
//  Created by user on 11/20/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("second view controller")
        let networkService = NetworkingService()
        
        networkService.getAvatars { (result) in
            switch (result) {
            case .failure(let error):
                print(error)
            case .success(let response):
                print("asdfasdfaf \(response.data)")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
