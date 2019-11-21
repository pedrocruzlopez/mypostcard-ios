//
//  ViewController.swift
//  MyPostcardChallenge
//
//  Created by user on 11/19/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        let message = Message(email: userNameTextField.text!, password: passwordTextField.text!)
        let networkService = NetworkingService();
        networkService.login(message) { result in
            switch result {
            case .failure( _):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "The credentials are not valid", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        

                    self.present(alert, animated: true)
                }
            case .success(let message):
                print(message)
                
            }
        }
        
    }
    
}

