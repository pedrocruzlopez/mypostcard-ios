//
//  TableViewCell.swift
//  MyPostcardChallenge
//
//  Created by user on 11/21/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var avatarImage: UIImageView!
    
    @IBOutlet var avatarTitle: UILabel!
    
    @IBOutlet var avatarUsed: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
