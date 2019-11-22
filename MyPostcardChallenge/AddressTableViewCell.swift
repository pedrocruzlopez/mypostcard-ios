//
//  AddressTableViewCell.swift
//  MyPostcardChallenge
//
//  Created by user on 11/22/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    
    @IBOutlet var line1: UILabel!
    
    @IBOutlet var line2: UILabel!
    
    @IBOutlet var line3: UILabel!
    
    @IBOutlet var line4: UILabel!
    
    @IBOutlet var line5: UILabel!
    
    @IBOutlet var line6: UILabel!
    
    @IBOutlet var line7: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
