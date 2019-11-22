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
    
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 15
        loginButton.clipsToBounds = true
    }

    @IBAction func loginAction(_ sender: Any) {
        let message = Message(email: userNameTextField.text!, password: passwordTextField.text!)
        let networkService = NetworkingService();
        networkService.login(message) { result in
            switch result {
            case .failure( _):
                self.showAlert("Error", "The credentials are not valid")
            case .success( let loginResponse):
                
                networkService.getAvatars { (result) in
                    switch (result) {
                    case .failure( _):
                        self.showAlert("Error", "Something went wrong, please try again later")
                    case .success(let responseAvatars):
                        
                        DispatchQueue.main.async {
                            
                            Session.shared.setSessionToken(loginResponse.jwt)
                            
                            networkService.getAddresses { (result) in
                                switch(result){
                                case .failure(_):
                                    self.showAlert("Error", "Something went wrong, please try again later")
                                case .success(let responseAddresses):
                                    
                                    DispatchQueue.main.async {
                                        let tab = self.storyboard?.instantiateViewController(identifier: "tabBar") as! UITabBarController
                                        tab.isModalInPresentation = true
                                        let vc = tab.viewControllers?[0] as! TableViewController
                                        vc.data = responseAvatars.data
                                        let avc = tab.viewControllers?[1] as! AddressTableViewController
                                        avc.data = responseAddresses.data
                                        self.present(tab, animated: true, completion: nil)
                                    }
                                    
                                
                                }
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

