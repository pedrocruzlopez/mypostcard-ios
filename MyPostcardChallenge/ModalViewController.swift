//
//  ModalViewController.swift
//  MyPostcardChallenge
//
//  Created by user on 11/22/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet var avatarLabel: UILabel!
    
    var avatarTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
        avatarLabel.text! = avatarTitle!
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
