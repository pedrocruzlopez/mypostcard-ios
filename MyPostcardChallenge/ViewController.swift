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
        userNameTextField.text = "technik@mypostcard.com"
        passwordTextField.text = "MyCodeChal19"
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        let message = Message(email: userNameTextField.text!, password: passwordTextField.text!)
        let networkService = NetworkingService();
        networkService.login(message) { result in
            switch result {
            case .failure( _):
                self.showAlert("Error", "The credentials are not valid")
            case .success( _):
                
                networkService.getAvatars { (result) in
                    switch (result) {
                    case .failure( _):
                        self.showAlert("Error", "Something went wrong, please try again later")
                    case .success(let response):
                        
                        DispatchQueue.main.async {
                            let vc = self.storyboard?.instantiateViewController(identifier: "secondViewController") as! TableViewController
                            vc.data = response.data
                            self.present(vc, animated: true) {
                                print("finish")
                            }
                        }
                        
                    }
                }
                
                
                
                
            }
        }
        
    }
    
    func showAlert(_ title: String, _ messsage: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)
        }
    }
    
}

